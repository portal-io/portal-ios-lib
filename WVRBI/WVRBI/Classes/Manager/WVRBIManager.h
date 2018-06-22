//
//  WVRBIManager.h
//  WhaleyVR
//
//  Created by Bruce on 2017/7/19.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WVRPayModel, WVRVideoEntity;

#import "WVRBIModel.h"

// startplay, endplay, pause, continue, startbuffer, endbuffer, lowbitrate
typedef NS_ENUM(NSInteger, BIActionType) {
    
    BIActionTypeStartplay,
    BIActionTypeEndplay,
    BIActionTypePause,
    BIActionTypeContinue,
    BIActionTypeStartbuffer,
    BIActionTypeEndbuffer,
    BIActionTypeLowbitrate,
};


typedef NS_ENUM(NSInteger, BITopicActionType) {
    
    BITopicActionTypeBrowse,
    BITopicActionTypeListPlay,
    BITopicActionTypeItemPlay,
//    BITopicActionTypeShare,
};


typedef NS_ENUM(NSInteger, BIDetailActionType) {
    
    BIDetailActionTypeBrowseVR,
    BIDetailActionTypeCollectionVR,
    BIDetailActionTypeDownloadVR,
    BIDetailActionTypeBrowseLivePrevue,
    BIDetailActionTypeBrowseLivePlay,
    BIDetailActionTypeReserveLive,
//    BIDetailActionTypeShare,
};


typedef NS_ENUM(NSInteger, BIPayActionType) {
    
    BIPayActionTypeBrowse,
    BIPayActionTypeSuccess,
};

@interface WVRBIManager : NSObject

/**
 将BIModel的数据序列化为json存储至SQLite

 @param model WVRBIModel
 */
+ (void)saveModelToLocal:(WVRBIModel *)model;

/**
 上传BI日志
 */
+ (void)uploadBIEvents;

@end
