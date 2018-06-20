//
//  WVRDeviceModel.m
//  VRManager
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 Snailvr. All rights reserved.

// 用来获取设备相关信息

#import "WVRDeviceModel.h"
#import "SAMKeychain.h"
#import <sys/sysctl.h>
#import <mach/vm_statistics.h>
#import <mach/mach_host.h>
#import<CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation WVRDeviceModel

#define SAMKeychain_Service  (@"uuid")
#define SAMKeychain_Account (@"com.snailvr.glasswork")

static NSString *kcurrentDeviceUUIDStr = nil;

// 获取设备唯一ID
+ (NSString *)vendorUUID {
    
    if (kcurrentDeviceUUIDStr.length > 1) {
        return kcurrentDeviceUUIDStr;
    }
    
    NSString *currentDeviceUUIDStr = [SAMKeychain passwordForService:SAMKeychain_Service account:SAMKeychain_Account];
    if (currentDeviceUUIDStr.length < 1) {
        
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SAMKeychain setPassword:currentDeviceUUIDStr forService:SAMKeychain_Service account:SAMKeychain_Account];
    }
    kcurrentDeviceUUIDStr = currentDeviceUUIDStr;
    
    return currentDeviceUUIDStr ?: @"";
}

+ (NSString *)deviceModel {
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    /*
     上面代码也可以使用下面代码替代👇
     struct utsname systemInfo;
     uname(&systemInfo);
     NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
     */
    
    // MARK: - Simulator
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) { return @"iPhoneSimulator"; }
    
    // MARK: - iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) { return @"iPhone2G"; }
    if ([platform isEqualToString:@"iPhone1,2"]) { return @"iPhone3G"; }
    if ([platform isEqualToString:@"iPhone2,1"]) { return @"iPhone3GS"; }
    if ([platform isEqualToString:@"iPhone3,1"] || [platform isEqualToString:@"iPhone3,2"] || [platform isEqualToString:@"iPhone3,3"]) { return @"iPhone4"; }
    if ([platform isEqualToString:@"iPhone4,1"]) { return @"iPhone4S"; }
    if ([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"]) { return @"iPhone5"; }
    if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"]) { return @"iPhone5c"; }
    if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"]) { return @"iPhone5s"; }
    
    if ([platform isEqualToString:@"iPhone7,2"]) { return @"iPhone6"; }
    if ([platform isEqualToString:@"iPhone7,1"]) { return @"iPhone6Plus"; }
    if ([platform isEqualToString:@"iPhone8,1"]) { return @"iPhone6s"; }
    if ([platform isEqualToString:@"iPhone8,2"]) { return @"iPhone6sPlus"; }
    if ([platform isEqualToString:@"iPhone8,3"] || [platform isEqualToString:@"iPhone8,4"]) { return @"iPhoneSE"; }
    if ([platform isEqualToString:@"iPhone9,1"] || [platform isEqualToString:@"iPhone9,3"]) { return @"iPhone7"; }
    if ([platform isEqualToString:@"iPhone9,2"] || [platform isEqualToString:@"iPhone9,4"])   { return @"iPhone7Plus"; }
    if ([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"])   { return @"iPhone8"; }
    if ([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"])   { return @"iPhone8Plus"; }
    if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"])   { return @"iPhoneX"; }
    
    // MARK: - iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])  { return @"iPodTouch"; }
    if ([platform isEqualToString:@"iPod2,1"])  { return @"iPodTouch2G"; }
    if ([platform isEqualToString:@"iPod3,1"])  { return @"iPodTouch3G"; }
    if ([platform isEqualToString:@"iPod4,1"])  { return @"iPodTouch4G"; }
    if ([platform isEqualToString:@"iPod5,1"])  { return @"iPodTouch5G"; }
    if ([platform isEqualToString:@"iPod7,1"])  { return @"iPodTouch6G"; }
    
    // MARK: - iPad
    if ([platform isEqualToString:@"iPad1,1"])  { return @"iPad"; }
    if ([platform isEqualToString:@"iPad2,1"] || [platform isEqualToString:@"iPad2,2"] || [platform isEqualToString:@"iPad2,3"] || [platform isEqualToString:@"iPad2,4"])  { return @"iPad2"; }
    if ([platform isEqualToString:@"iPad3,1"] || [platform isEqualToString:@"iPad3,2"] || [platform isEqualToString:@"iPad3,3"])  { return @"iPad3"; }
    if ([platform isEqualToString:@"iPad3,4"] || [platform isEqualToString:@"iPad3,5"] || [platform isEqualToString:@"iPad3,6"])  { return @"iPad4"; }
    
    // MARK: - iPad Air
    if ([platform isEqualToString:@"iPad4,1"] || [platform isEqualToString:@"iPad4,2"] || [platform isEqualToString:@"iPad4,3"])  { return @"iPadAir"; }
    if ([platform isEqualToString:@"iPad5,3"] || [platform isEqualToString:@"iPad5,4"])  { return @"iPadAir2"; }
    if ([platform isEqualToString:@"iPad6,11"] || [platform isEqualToString:@"iPad6,12"])    return @"iPadAir3";
    
    // MARK: - iPad Pro
    if ([platform isEqualToString:@"iPad6,7"] || [platform isEqualToString:@"iPad6,8"])   { return @"iPad Pro 12.9-inch"; }
    if ([platform isEqualToString:@"iPad6,3"] || [platform isEqualToString:@"iPad6,4"])   { return @"iPad Pro iPad 9.7-inch"; }
    if ([platform isEqualToString:@"iPad7,1"] || [platform isEqualToString:@"iPad7,2"])   { return @"iPad Pro 12.9-inch 2"; }
    if ([platform isEqualToString:@"iPad7,3"] || [platform isEqualToString:@"iPad7,4"])   { return @"iPad Pro 10.5-inch"; }
    
    // MARK: - iPad mini
    if ([platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,7"])  { return @"iPadmini1G"; }
    if ([platform isEqualToString:@"iPad4,4"] || [platform isEqualToString:@"iPad4,5"] || [platform isEqualToString:@"iPad4,6"])  { return @"iPadmini2"; }
    if ([platform isEqualToString:@"iPad4,7"] || [platform isEqualToString:@"iPad4,8"] || [platform isEqualToString:@"iPad4,9"])  { return @"iPadmini3"; }
    if ([platform isEqualToString:@"iPad5,1"] || [platform isEqualToString:@"iPad5,2"])  { return @"iPadmini4"; }
    
    return platform;
}

+ (long long)totalMemorySize {
    
    return [NSProcessInfo processInfo].physicalMemory;
}

+ (long long)availableMemorySize {
    
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

+ (BOOL)is4KSupport {
    
    long long size = [NSProcessInfo processInfo].physicalMemory / 1024 / 1024;
    
    return (size > 1900);      // 物理内存大于1900M
}

+ (NSString *)deviceIPAdress {
    
    NSString *address = @"0.0.0.0";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    NSLog(@"手机的IP是：%@", address);
    return address;
}

@end
