//
//  NSURL+Extend.h
//  WhaleyVR
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Extend)

// 防止图片链接中出现中文而导致图片加载失败   当url中使用#作为定位标识符的时候不适用本方法
+ (NSURL *)URLWithUTF8String:(NSString *)URLString;

@end
