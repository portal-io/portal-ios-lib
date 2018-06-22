//
//  LPHotPoint.h
//  LuaParser
//
//  Created by liuyong on 15/12/28.
//  Copyright © 2015年 Whaley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHotPoint : NSObject

+ (LPHotPoint *)hotPointWithDict:(NSDictionary *)aDict;

@property NSString* type;
@property int time;
@property NSString* info;

@end
