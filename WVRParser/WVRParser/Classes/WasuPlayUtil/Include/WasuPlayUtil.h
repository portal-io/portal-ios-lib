//
//  WasuPlayUtil.h
//  WasuTVPublic
//
//  Created by Grace on 15/7/20.
//  Copyright (c) 2015年 wasu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WasuPlayUtil : NSObject
+(NSString *)getRealPlayUrl:(NSString *)cid AssetId:(NSString *)vid PlayUrl:(NSString *)playUrl isDownload:(BOOL)state;;
@end
