//
//  ProxyServer.m
//  yeqq
//
//  Created by fxs on 15/5/21.
//  Copyright (c) 2015年 User. All rights reserved.
//  by Fanxiushu 2015-05-14

#include <sys/types.h>
#include <sys/stat.h>
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include <signal.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <pthread.h>
#include <stdarg.h>
#include <unistd.h>
#include <arpa/inet.h>  // For inet_pton() when NS_ENABLE_IPV6 is defined
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/select.h>

#import <Foundation/Foundation.h>
#import "WLYPlayerUtils.h"

#define TYPE_UNKNOWN 0
#define TYPE_SINGLEFILE 1
#define TYPE_M3U8 2
int resourceType_2 = TYPE_UNKNOWN;

@interface ProxyPerClient : NSObject

@property (nonatomic) int sock;
@property (nonatomic, strong) NSURLConnection *conn;

@end


static int          proxy_listen_fd = -1;
static unsigned int proxy_restart_count = 0;
static int          proxy_listen_port = 0;
int                 g_acceptSock = -1;

void CloseSock()
{
    if (g_acceptSock >= 0) {
        shutdown(g_acceptSock, 2);
        close(g_acceptSock);
        g_acceptSock = -1;
    }
}

void sendData(NSData *data) {
    
    int r = -1;
    if (g_acceptSock >= 0) {
        char *buf = (char *)malloc(data.length);
        memcpy(buf, data.bytes, data.length);
        
        r = (int)send(g_acceptSock, buf, data.length, 0);
        
        free(buf);
    }
    
    if (r <= 0) {
        NSLog(@"%s, Error No = %d", __func__, errno);
        CloseSock();
    }
}

void SendResponse(NSUInteger statusCode, NSDictionary *headers, NSData *body) {
    
    //get stataus line
    NSString *statusLine = [NSString stringWithFormat:@"HTTP/1.1 %@ %@\r\n", @(statusCode), [WLYPlayerUtils statusForCode:statusCode]];
    NSMutableString *headerss = [[NSMutableString alloc] initWithString:statusLine];
    //get headers
    NSMutableDictionary *responseHeaders = [headers mutableCopy];
    if (responseHeaders == nil) {
        responseHeaders = [[NSMutableDictionary alloc] init];
    }
    responseHeaders[@"Content-Length"] = @([body length]);
    responseHeaders[@"Connection"] = @"Close";
    responseHeaders[@"Server"] = @"Linux/2.6.34-g4150423-dirty HTTP/1.1";
    responseHeaders[@"Content-Type"] = @"application/x-mpegURL";
    [responseHeaders enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *header = [NSString stringWithFormat:@"%@: %@\r\n", key, obj];
        [headerss appendString:header];
    }];
    //get seperation line
    [headerss appendString:@"\r\n"];
    
    //send headers
    sendData([headerss dataUsingEncoding:NSASCIIStringEncoding]);
    
    //send body
    if ([body length]) {
        sendData(body);
    }
}

static void do_client(int sock) {

    g_acceptSock = sock;
    
    //get request
    char buf[4096];
    int pos = 0;
    while(pos < 4096) {
        int r = (int)recv(sock, (buf + pos), (size_t)(4096 - pos), 0);
        
        if (r <= 0) {
            NSLog(@"%s, Error No = %d, r = %d", __func__, errno, r);
            close(sock);
            return;
        }
        pos += r;
        buf[pos] = 0;
        char *ptr = strstr(buf, "\r\n\r\n");
        if (ptr) {
            *(ptr + 2) = 0;
            break;
        }
    }
    
    //analyze request
    char* hdr = buf;
    NSString *payload = [NSString stringWithUTF8String:hdr];
    NSArray *lines = [payload componentsSeparatedByString:@"\r\n"];
    NSString *requestLine = [lines firstObject];
    lines = [lines subarrayWithRange:NSMakeRange(1, [lines count] - 3)];
    NSArray *requestWords = [requestLine componentsSeparatedByString:@" "];
    
    NSString *method = nil;
    NSString *path = nil;
    NSString *HTTPVersion = nil;
    if ([requestWords count] == 3) {
        //
        method = requestWords[0];
        path = requestWords[1];
        HTTPVersion = requestWords[2];
        
        if ([HTTPVersion hasPrefix:@"HTTP/1"] == NO) {
            SendResponse(400, nil, nil);
            return;
        }
    } else {
        SendResponse(400, nil, nil);
        return;
    }
    
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    for (NSString *line in lines) {
        NSRange seperatorRange = [line rangeOfString:@":"];
        
        if (seperatorRange.location != NSNotFound) {
            NSString *key = [line substringToIndex:seperatorRange.location];
            NSString *value = [line substringFromIndex:(seperatorRange.location + seperatorRange.length)];
            
            if ([value hasPrefix:@" "]) {
                value = [value substringFromIndex:1];
            }
            headers[key] = value;
        } else {
            SendResponse(400, nil, nil);
            return;
        }
    }

    if ([method isEqualToString:@"GET"]) {
        NSString *pathTemp = [path stringByRemovingPercentEncoding];
        NSDictionary *params = [WLYPlayerUtils getParameterList:pathTemp];
        NSString *action = [params objectForKey:@"Action"];
        if (nil == action || [action isEqualToString:@"agent"]) {
            //get url
            NSString* urlString = [WLYPlayerUtils decodeString:[params objectForKey:@"url"]];
            
            NSString *tsVal = [params objectForKey:@"ts"];
            NSString *hashVal = [params objectForKey:@"hash"];
            NSString *envVal = [params objectForKey:@"environment"];
            if ([tsVal length] > 0) {
                urlString = [urlString stringByAppendingFormat:@"&ts=%@", tsVal];
            }
            if ([hashVal length] > 0) {
                urlString = [urlString stringByAppendingFormat:@"&hash=%@", hashVal];
            }
            if ([envVal length] > 0) {
                urlString = [urlString stringByAppendingFormat:@"&environment=%@", envVal];
            }
            
            //get curExt
            NSString *curExt = [params objectForKey:@"curExt"];
            if ([curExt length] == 0) {
                if ([urlString hasPrefix:@"/"]) {
                    //local file
                    if ([urlString hasSuffix:@".m3u8"]) {
                        resourceType_2 = TYPE_M3U8;
                    } else {
                        resourceType_2 = TYPE_SINGLEFILE;
                    }
                } else if ([urlString hasPrefix:@"http"]) {
                    //http file
                    if ([urlString hasSuffix:@".m3u8"]) {
                        resourceType_2 = TYPE_M3U8;
                    } else {
                        resourceType_2 = TYPE_SINGLEFILE;
                    }
                } else {
                    resourceType_2 = TYPE_UNKNOWN;
                }
            } else if ([curExt caseInsensitiveCompare:@"m3u8"] == NSOrderedSame) {
                resourceType_2 = TYPE_M3U8;
            } else {
                resourceType_2 = TYPE_SINGLEFILE;
            }
            
//            NSLog(@"%s, url = %@", __func__, urlString);
            if ([urlString hasPrefix:@"http"]) {
                //
                NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
                
                //add user agent header
                NSString *userAgent = @"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.0 Safari/537.36";
                //[urlRequest setValue:@"ios+android" forHTTPHeaderField:@"User-Agent"];
                [urlRequest setValue:userAgent forHTTPHeaderField:@"User-Agent"];
                [urlRequest setValue:@"close" forHTTPHeaderField:@"Connection"];
                urlRequest.timeoutInterval = 45.0;
                
                //add request headers
                for (NSString* key in headers) {
                    if ([key isEqualToString:@"Host"]) {
                        //do nothing
                    } else if ([key isEqualToString:@"Range"]) {       // changed  line 302-306
                        if (resourceType_2 == TYPE_M3U8) {
                            [urlRequest setValue:@"" forHTTPHeaderField:key];
                        }
                    } else {
                        [urlRequest setValue:[headers objectForKey:key] forHTTPHeaderField:key];
                    }
                }
                
                //add ext headers
                if ([WLYPlayerUtils getParseResult] != nil) {
                    if ([WLYPlayerUtils getParseResult].head != nil) {
                        NSDictionary *extHeaders = [WLYPlayerUtils getParseResult].head;
                        NSEnumerator *extHeaderKeys = [extHeaders keyEnumerator];
                        for (NSString *key in extHeaderKeys) {
                            [urlRequest setValue: [extHeaders objectForKey:key] forHTTPHeaderField:key];
                        }
                    }
                }
                
                NSString *domain = [WLYPlayerUtils getDomainFromUrl:urlString];
                NSString *prefix = @"http://127.0.0.1:12581/?Action=agent";
                
                if (resourceType_2 == TYPE_M3U8) {
                    //*
                    //response: m3u8
                    NSURLResponse *m3u8Response = nil;
                    NSError *error = nil;
//                    NSLog(@"%s, Firing synchronous url connection...", __func__);
                    
                    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&m3u8Response error:&error];
                    
                    // 这里将NSURLResponse对象转换成NSHTTPURLResponse对象
                    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)m3u8Response;
                    NSDictionary *responseHeaders = nil;
                    //write status line
                    NSInteger statusCode = urlResponse.statusCode;
//                    NSLog(@"Agent StatusCode === %ld", statusCode);
                    if (statusCode == 302) {
                        //do redirect
                        urlString = [[urlResponse allHeaderFields] objectForKey:@"Location"];
//                        NSLog(@"%s, get m3u8 file redirect to: %@", __func__, urlString);
                        [urlRequest setURL:[NSURL URLWithString:urlString]];
                        data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&m3u8Response error:&error];
                    }
                    if (statusCode >= 200 && statusCode < 300) {
//                    if (statusCode == 200) {
                        if ([urlResponse respondsToSelector:@selector(allHeaderFields)]) {
                            responseHeaders = [urlResponse allHeaderFields];
//                            NSLog(@"%s, get m3u8 response headers = %@",__func__, responseHeaders);
                        }
                        //get body
                        NSData *body = nil;
                        NSString *m3u8Ret = [WLYPlayerUtils modifyRemoteM3u8String:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] prefix:prefix host:domain];
                        body = [m3u8Ret dataUsingEncoding:NSUTF8StringEncoding];
                        
                        SendResponse(statusCode, responseHeaders, body);

                    } else {
                        //response: error
                        NSLog(@"%s, error statusCode = %d", __func__, (int)statusCode);
                        
                        SendResponse(statusCode, nil, nil);
                        return;
                    }//*/
                    /*
                    ProxyPerClient* proxy = [[ProxyPerClient alloc] init];
                    proxy.sock = sock;
                    
                    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:proxy startImmediately:NO];
                    proxy.conn = conn;
                    [conn setDelegateQueue:[[NSOperationQueue alloc] init]]; /// enter Queue for execute
                    [conn start];
                     */
                } else if (resourceType_2 == TYPE_SINGLEFILE) {
                    //response: ts
                    ProxyPerClient *proxy = [[ProxyPerClient alloc] init];
                    proxy.sock = sock;
                    
                    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:proxy startImmediately:NO];
                    proxy.conn = conn;
                    [conn setDelegateQueue:[[NSOperationQueue alloc] init]]; /// enter Queue for execute
                    [conn start];
                } else {
                    //response: error
                    SendResponse(404, nil, nil);
                    return;
                }
            }
        }
    }
}

static int create_proxy_listen_socket(const char* strip, int port)
{
    if (proxy_listen_fd >= 0) {
        close(proxy_listen_fd);
        proxy_listen_fd = -1;
    }
    
    int fd = socket(AF_INET, SOCK_STREAM,0);
    if (fd < 0) { return -1; }
    
    int set = 1;
    setsockopt(fd, SOL_SOCKET, SO_NOSIGPIPE, (void*)&set, sizeof(int));
    
    setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, (void*)&set, sizeof(int)); // reuse address
    
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr(strip);
    addr.sin_port = htons(port);
    
    if ( bind(fd, (struct sockaddr *)&addr, sizeof(addr) ) < 0) {
        close(fd);
//        NSLog(@"%s, bind error.", __func__);
        return -1;
    }
    
    listen(fd, 5);
    proxy_listen_fd = fd;
    
    memset(&addr, 0, sizeof(addr));
    socklen_t len = sizeof(addr);
    getsockname(fd, (struct sockaddr *)&addr, &len);
    
    proxy_listen_port = ntohs(addr.sin_port);
    
//    NSLog(@"%s, Listen [%s:%d]", __func__, inet_ntoa(addr.sin_addr), ntohs(addr.sin_port));
    
    return fd;
}

int start_proxy_server(const char *strip, int port) {
    
    signal(SIGPIPE, SIG_IGN);
    
    unsigned int restart_count = proxy_restart_count;
    
    int fd = create_proxy_listen_socket(strip, port);
    
    if (fd < 0) {
        NSLog(@"%s, Create Proxy Server Error.", __func__);
        return -1;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        int listen_fd = proxy_listen_fd;
        
        int err = 0;
        while (restart_count == proxy_restart_count) {
//            NSLog(@"本地代理守护中: %@", [NSThread currentThread]);
            
            fd_set rdst; FD_ZERO(&rdst); FD_SET(listen_fd, &rdst);
            struct timeval timeout; timeout.tv_sec = 1; timeout.tv_usec = 0;
            int status = select(listen_fd + 1, &rdst, NULL, NULL, &timeout);
            if (status <= 0) {
                if (status < 0) {
                    ++ err;
                    if (err >= 30) {
                        NSLog(@"%s, proxy FALTAL Error. Recreate Listen socket", __func__);
                        while (restart_count == proxy_restart_count) {
                            listen_fd = create_proxy_listen_socket(strip, port);
                            if (listen_fd >= 0) { break; }
                            
                            sleep(1);
                        }
                        err = 0;
                    }
                } else {
                    err = 0;
                }
                
                continue;
            }
            err = 0;
            
            int acceptSock = accept(listen_fd, NULL, NULL);
            if (acceptSock < 0) {
                ++ err;
                continue;
            }
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                int set = 1;
                setsockopt(fd, SOL_SOCKET, SO_NOSIGPIPE, (void *)&set, sizeof(int));
                
//                NSLog(@"listen_fd = %d, acceptSock = %d\n", listen_fd, acceptSock);
                
                do_client(acceptSock);
            });
        }
        
        close(proxy_listen_fd);
        proxy_listen_fd = -1;
        
        NSLog(@"%s, Proxy Server Listen Closed.", __func__);
    });
    return 0;
}

void stop_proxy_server() {
    
    ++ proxy_restart_count;
}

int get_proxy_port() {
    
    return proxy_listen_port;
}

/****
在iOS程序开始的地方，调用 start_proxy_server 来启动代理服务，本代理服务只是简单的把请求通过 NSURLConnection调用转发到服务端，并且只能处理 GET请求。
这为AVPlayer等视频播放控件的在线缓存提供了一个把网络数据流导向到  URL Loading System 提供了一个方便。

启动本代理之后，在处理 AVPlayer播放在线URL的时候，把真正的URL替换成代理URL即可，比如：
真正的URL是 http://www.v.com/video/a.mp4 
组合的代理URL则为如下：
"http://127.0.0.1:代理端口/http://www.v.com/video/a.pm4"

****/



@implementation ProxyPerClient

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
    int code = (int)[httpRes statusCode];
    
    char buf[4096];
    buf[0] = 0;
    sprintf(buf, "HTTP/1.1 %d OK\r\n", code);
    NSDictionary *dict = [httpRes allHeaderFields];
    for (NSString *key in dict) {
        NSString *val = [dict objectForKey:key];
        
        sprintf(buf + strlen(buf), "%s: %s\r\n", key.UTF8String, val.UTF8String);
    }
    sprintf(buf + strlen(buf), "\r\n");
    
    int r = -1;
    if (self.sock >= 0) { r = (int)send( self.sock, buf, (size_t)strlen(buf), 0); }
    
    if (r <= 0) {
        
        NSLog(@"%s, response code = %d", __func__, code);
        NSLog(@"%s, Error No = %d, url = %@", __func__, errno, connection.currentRequest.URL.absoluteString);
        [self.conn cancel];
        [self Close];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    int r = -1;
    if (self.sock >= 0) {
        char* buf = (char *)malloc(data.length);
        memcpy(buf, data.bytes, data.length);
        
        r = (int)send(self.sock, buf, data.length, 0);
        
        free(buf);
    }
    
    if (r <= 0) {
        NSLog(@"%s, Error No = %d, url = %@", __func__, errno, connection.currentRequest.URL.absoluteString);
        [self.conn cancel];
        [self Close];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
//    NSLog(@"%s", __func__);
    
    [self Close];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"%s, url = %@", __func__, connection.currentRequest.URL.absoluteString);
    NSLog(@"error: %@", error.description);
    
    [self Close];
}

- (void)Close
{
    if (self.sock >= 0) {
        shutdown(self.sock, 2);
        close(self.sock);
        self.sock = -1;
    }
}

@end

