//
//  NSArray+WVRNetworkingMethods.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/17.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "NSArray+WVRNetworkingMethods.h"

@implementation NSArray (WVRNetworkingMethods)

- (NSString *)AX_paramsString
{
    NSMutableString *paramString = [[NSMutableString alloc] init];
    
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([paramString length] == 0) {
            [paramString appendFormat:@"%@", obj];
        } else {
            [paramString appendFormat:@"&%@", obj];
        }
    }];
    
    return paramString;
}

/** Convert Array to JSON */
- (NSString *)AX_jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
