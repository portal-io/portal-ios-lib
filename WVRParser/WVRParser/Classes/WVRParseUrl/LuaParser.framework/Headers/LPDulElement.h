//
//  LPDulElement.h
//  LuaPaserTest
//
//  Created by liuyong on 15/12/21.
//  Copyright © 2015年 Whaley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPDulElement : NSObject

+ (LPDulElement *)elementWithDict:(NSDictionary *)aDict;

@property NSString* url;
@property int duration;
@property int size;
@property int index;
@property NSString* format;
@property BOOL isCached;

@end
