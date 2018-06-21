//
//  WVRNetworkingServiceFactory.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/20.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRNetworkingServiceFactory.h"

@interface WVRNetworkingServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation WVRNetworkingServiceFactory

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WVRNetworkingServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WVRNetworkingServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (WVRNetworkingService<WVRNetworkingServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

- (void)newServiceWithIdentifier:(NSString *)identifier {
    if (self.serviceStorage[identifier] == nil) {
        Class customerServiceClass = NSClassFromString(identifier);
        id customerService = [[customerServiceClass alloc] init];
        if (![customerService isKindOfClass:[WVRNetworkingService class]]) {
            NSAssert(NO, @"Customer Service must implement WVRNetworkingService");
        }
        self.serviceStorage[identifier] = customerService;
    }
}

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

@end
