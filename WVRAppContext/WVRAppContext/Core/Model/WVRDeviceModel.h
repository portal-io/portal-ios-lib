//
//  WVRDeviceModel.h
//  VRManager
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 Snailvr. All rights reserved.

// 用来获取设备相关信息，依赖于SAMKeychain

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WVRDeviceModel : NSObject

/// 设备唯一ID
+ (NSString *)vendorUUID;

/// 设备型号
+ (NSString *)deviceModel;

/// 设备总的RAM控件
+ (long long)totalMemorySize;

/// 设备可用的RAM空间
+ (long long)availableMemorySize;

/// 物理内存大于1900M
+ (BOOL)is4KSupport;

/// 获取设备IP地址
+ (NSString *)deviceIPAdress;

@end
