//
//  NSDictionary+WVRNetworkingMethods.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/17.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WVRNetworkingMethods)

- (NSString *)CT_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)CT_jsonString;
- (NSArray *)CT_transformedUrlParamsArraySignature:(BOOL)isForSignature;
- (NSString *)CT_urlParamsValuesStringSignature:(BOOL)isForSignature;
@end
