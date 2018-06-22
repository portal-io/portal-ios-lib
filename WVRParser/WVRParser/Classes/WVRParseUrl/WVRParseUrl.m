//
//  WVRParseUrl.m
//  VRManager
//
//  Created by Wang Tiger on 16/6/23.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRParseUrl.h"
#import "LuaParser/LPParser.h"
#import "WVRParserUrlResult.h"
#import "WLYPlayerUtils.h"
#import "SecurityFramework/Security.h"
#import "WVRAppDebugDefine.h"

@implementation WVRParseUrl

+ (void)parserUrl:(NSString *)originUrl callback:(WVRParserUrlCallback)aCallback {
    
    NSLog(@"Current ProcessName: %@", [[NSProcessInfo processInfo] processName]);
    
    WVRParserUrlResult *vrResult = [[WVRParserUrlResult alloc] init];
    if (![self checkOriginUrl:originUrl]) {
        aCallback(vrResult);
        return;
    }
    
    [[LPParser sharedParser] parseUrl:originUrl callback:^(LPParseResult *result) {
        
        LPParseResult *parseResult;
        NSArray<LPUrlElement*> *urlElementList;
        
        vrResult.isSuccessed = (result.resultType == kSuccess);
        if (result.resultType == kSuccess) {
            parseResult = result;
            urlElementList = [result getUrlElementList];
        } else {
            aCallback(vrResult);
            return;
        }
        
        BOOL have_SDA_SDB = NO;
        BOOL have_TDA_TDB = NO;
        
        NSMutableArray<WVRParserUrlElement *> *arr = [NSMutableArray array];
        for (LPUrlElement *urlElement in urlElementList) {
            
            NSURL *moguvUrl = [WVRParseUrl parseMoguvUrl:[[urlElement.dullist firstObject] url] pResult:parseResult];
            
            if (urlElement.bittype && moguvUrl) {
                WVRParserUrlElement *model = [[WVRParserUrlElement alloc] init];
                model.url = moguvUrl;
                model.algorithm = urlElement.algorithm;
                model.definition = urlElement.bittype;
                
                [arr addObject:model];
            }
            
            DDLogInfo(@"\n链接清晰度：%@ - 播放链接：%@", urlElement.bittype, [moguvUrl.absoluteString stringByRemovingPercentEncoding]);
        }
        
        for (WVRParserUrlElement *urlElement in arr) {
            if (DefinitionTypeSDA == urlElement.defiType) {
                
                have_SDA_SDB = YES;
                break;
            }
            if (DefinitionTypeSDB == urlElement.defiType) {
                
                have_SDA_SDB = YES;
                break;
            }
        }
        
        for (WVRParserUrlElement *urlElement in arr) {
            if (DefinitionTypeTDA == urlElement.defiType) {
                
                have_TDA_TDB = YES;
                break;
            }
            if (DefinitionTypeTDB == urlElement.defiType) {
                
                have_TDA_TDB = YES;
                break;
            }
        }
        
        vrResult.urlElementList = arr;
        vrResult.haveSDA_SDB = have_SDA_SDB;
        vrResult.haveTDA_TDB = have_TDA_TDB;
        
        DDLogInfo(@"\nhaveSDA_SDB：%@", have_SDA_SDB ? @"YES" : @"NO");
        DDLogInfo(@"\nhaveTDA_TDB：%@", have_TDA_TDB ? @"YES" : @"NO");
        
        if (aCallback) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                aCallback(vrResult);
            });
        }
        
    } targetQuality: kHD];
}

+ (NSURL *)parseMoguvUrl:(NSString *)url pResult:(LPParseResult *)parseResult {
        
    if (![self checkOriginUrl:url]) { return nil; }
    
    BOOL isUseAgent = (parseResult == nil) ? NO : parseResult.useHttpAgent;
    BOOL isMoguv = (parseResult == nil) ? NO : parseResult.isMoguv;
    NSString *curExt = parseResult.curext;
    NSURL *finalUrl;
    
    [WLYPlayerUtils setToken:@""];
    [WLYPlayerUtils setParseResult:parseResult];
        
    if (isMoguv) {
        if ([curExt isEqualToString:@"m3u8"]) {
                //
            NSDictionary* params = [WLYPlayerUtils getParameterList:url];
            NSString *tokenVal = [params objectForKey:@"token"];
            NSString *tsVal = [params objectForKey:@"ts"];
            NSString *token = @"";
            if (tokenVal != nil && [tokenVal length] > 0) {
                token = [@"token=" stringByAppendingString:tokenVal];
            }
            
            if (tsVal != nil && [tsVal length] > 0) {
                if ([token length] > 0) {
                    token = [token stringByAppendingFormat:@"&ts=%@", tsVal];
                }else {
                    token = [@"ts=" stringByAppendingString:tsVal];
                }
            }
            //set security token for m3u8
            [WLYPlayerUtils setToken:token];
            Security *sc = [Security getInstance];
            url = [sc Security_GetUrl:url WithAlgid:sc.cdnAlgid];
            url = [url stringByAppendingFormat:@"&%@", @"curExt=m3u8"];
                isUseAgent = YES;
        } else {
            //do security
            Security *sc = [Security getInstance];
            url = [sc Security_GetUrl:url WithAlgid:sc.cdnAlgid];
            isUseAgent = NO;
        }
    }
    if ([url hasPrefix:@"https"]) {
        isUseAgent = YES;
    }
    if ([url hasPrefix:@"/"] && [url hasSuffix:@"m3u8"]) {
        isUseAgent = YES;
    }
    if (isUseAgent) {
        finalUrl = [NSURL URLWithString:[WLYPlayerUtils getAgentUrl:url]];
    } else {
        finalUrl = [NSURL URLWithString:url];
    }
//    NSLog(@"Parse Final Url -- %@", [[finalUrl absoluteString] stringByRemovingPercentEncoding]);
    return finalUrl;
}

+ (BOOL)checkOriginUrl:(NSString *)originUrl {
    
    if (![originUrl isKindOfClass:[NSString class]]) {
        return NO;
    }
    if (originUrl.length == 0) {
        return NO;
    }
    
    return YES;
}

@end
