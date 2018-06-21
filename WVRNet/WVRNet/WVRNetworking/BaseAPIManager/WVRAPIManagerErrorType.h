//
//  WVRAPIManagerErrorType.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/22.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#ifndef WVRAPIManagerErrorType_h
#define WVRAPIManagerErrorType_h

typedef NS_ENUM (NSUInteger, WVRAPIManagerErrorType){
    WVRAPIManagerErrorTypeDefault,
    WVRAPIManagerErrorTypeSuccess,
    WVRAPIManagerErrorTypeNoContent,
    WVRAPIManagerErrorTypeContentError,
    WVRAPIManagerErrorTypeParamsError,
    WVRAPIManagerErrorTypeTimeout,
    WVRAPIManagerErrorTypeNoNetWork
};

#endif /* WVRAPIManagerErrorType_h */
