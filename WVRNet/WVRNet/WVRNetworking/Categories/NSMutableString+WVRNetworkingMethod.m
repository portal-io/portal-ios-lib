//
//  NSMutableString+WVRNetworkingMethod.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/23.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "NSMutableString+WVRNetworkingMethod.h"
#import "NSObject+WVRNetworkingMethods.h"

@implementation NSMutableString (WVRNetworkingMethod)
- (void)appendURLRequest:(NSURLRequest *)request
{
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] WVR_defaultValue:@"\t\t\t\tN/A"]];
}

@end
