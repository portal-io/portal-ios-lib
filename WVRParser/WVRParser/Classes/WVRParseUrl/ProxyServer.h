//
//  ProxyServer.h
//  Pods
//
//  Created by 黄太烽 on 16/2/29.
//
//

#ifndef ProxyServer_h
#define ProxyServer_h

#import <LuaParser/LPParseResult.h>

int start_proxy_server(const char* strip, int port);
void stop_proxy_server();

#endif
