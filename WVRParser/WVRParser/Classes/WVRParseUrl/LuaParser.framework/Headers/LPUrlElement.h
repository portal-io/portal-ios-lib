//
//  LPUrlElement.h
//  LuaPaserTest
//
//  Created by liuyong on 15/12/21.
//  Copyright © 2015年 Whaley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPDulElement.h"

@interface LPUrlElement : NSObject
+ (LPUrlElement*) elementWithDict: (NSDictionary*) aDict;

@property int size;
@property int duration;
@property int bitrate;
@property int dulnum;
@property int timeout;
@property NSString* bittype;
@property NSMutableArray<LPDulElement*> * dullist;
@property BOOL isCached;
@property BOOL isList;
@property NSString* algorithm;
@end
