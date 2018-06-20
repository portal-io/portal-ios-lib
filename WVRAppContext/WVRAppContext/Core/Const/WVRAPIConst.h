//
//  WVRAPIConst.h
//  VRManager
//
//  Created by Snailvr on 16/6/23.
//  Copyright © 2016年 Snailvr. All rights reserved.

// 定义通用型的block，全局常量，枚举等

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Network

typedef void(^APIResponseBlock)(NSDictionary *responseObj, NSError *error);

#pragma mark - key

UIKIT_EXTERN NSString * const TEST_USER_HISTORY_SIGN_SECRET;
UIKIT_EXTERN NSString * const USER_HISTORY_SIGN_SECRET;

// 用户购买key
UIKIT_EXTERN NSString * const TEST_USER_PURCHASE_SIGN_SECRET;
UIKIT_EXTERN NSString * const USER_PURCHASE_SIGN_SECRET;

#pragma mark - toast text

UIKIT_EXTERN NSString *const kAlertTitle;
UIKIT_EXTERN NSString *const kToastShow;
UIKIT_EXTERN NSString *const kNoMoreData;
UIKIT_EXTERN NSString *const kNetError;
UIKIT_EXTERN NSString *const kPlayError;
UIKIT_EXTERN NSString *const kLoadError;
UIKIT_EXTERN NSString *const kLinkError;
UIKIT_EXTERN NSString *const kReloadData;
UIKIT_EXTERN NSString *const kNoNetAlert;
UIKIT_EXTERN NSString *const kReachAlert;

UIKIT_EXTERN NSString *const kToastLiveOver;
UIKIT_EXTERN NSString *const kToastProgramInvalid;
UIKIT_EXTERN NSString *const kToastChargeLottery;
UIKIT_EXTERN NSString *const kToastChargeDanmu;
UIKIT_EXTERN NSString *const kToastCollectionSuccess;
UIKIT_EXTERN NSString *const kToastCollectionFail;
UIKIT_EXTERN NSString *const kToastCancelCollectionSuccess;
UIKIT_EXTERN NSString *const kToastCancelCollectionFail;
UIKIT_EXTERN NSString *const kToastNotChargeToUnity;

UIKIT_EXTERN NSString *const kToastAttentionSuccess;
UIKIT_EXTERN NSString *const kToastAttentionFail;
UIKIT_EXTERN NSString *const kToastCancelAttentionSuccess;
UIKIT_EXTERN NSString *const kToastCancelAttentionFail;

UIKIT_EXTERN NSString *const kToastNoChangeDefinition;

#pragma mark - API

UIKIT_EXTERN NSString *const kAPI_WHALEY_ACCOUNT_BASE_URL;

UIKIT_EXTERN NSString *const kAPI_NEW_VR_BASE_URL_TEST;
UIKIT_EXTERN NSString *const kAPI_NEW_VR_BASE_URL_ONLINE;

UIKIT_EXTERN NSString *const kAPI_STORE_BASE_URL_TEST;
UIKIT_EXTERN NSString *const kAPI_STORE_BASE_URL_ONLINE;

UIKIT_EXTERN NSString *const kAPI_WHALEY_BI_BASE_URL_ONLINE;
UIKIT_EXTERN NSString *const kAPI_WHALEY_BI_BASE_URL_TEST;

UIKIT_EXTERN NSString *const kAPI_WHALEY_BUS_BASE_URL;

UIKIT_EXTERN NSString *const kAPI_SNAILVR_BASE_URL_DEV;
UIKIT_EXTERN NSString *const kAPI_SNAILVR_BASE_URL_TEST;
UIKIT_EXTERN NSString *const kAPI_SNAILVR_BASE_URL_ONLINE;

UIKIT_EXTERN NSString *const kAPI_PLATFORM;
UIKIT_EXTERN NSString *const kAPI_SERVICE;

extern CGFloat const kHTTPPageSize;
extern CGFloat const kHideToolBarTime;


#pragma mark - ENUM

/// 二级瀑布流列表

typedef NS_ENUM(NSInteger, WVRItemCellStyle) {
    
    WVRItemCellStyleNormal = 1,                      // 普通状态  VR  该值不能为空
    WVRItemCellStyleLive,                            // 直播
    WVRItemCellStyleMovie,                           // 电影
    WVRItemCellStyleBrand                            // 品牌专区
};

/// 视频流类型

typedef NS_ENUM(NSInteger, WVRStreamType) {
    
    STREAM_VR_VOD = 1,             // 普通全景视频
    STREAM_3D_WASU = 2,            // 华数3D电影
    STREAM_VR_LIVE = 3,            // VR直播
    STREAM_VR_LOCAL = 4,           // 本地视频(下载)
    STREAM_2D_TV = 5,              // 电视猫电视剧、电视猫电影
//    STREAM_VR_USER = 6,            // 用户视频(本地) [预留]
};

/// 与const： kDefinition_ST、一一对应

typedef NS_ENUM(NSInteger, DefinitionType) {
    
    DefinitionTypeST,           // 高清，2k球面
    DefinitionTypeSD,           // 超清，2k八面体
    DefinitionTypeHD,           // 原画，4k球面
    DefinitionTypeAUTO,         // 未知
    DefinitionTypeXD,           // 蓝光，平面面，电视猫电视剧和电影独有
    DefinitionTypeSDA,          // 1.5M，高清，八面体
    DefinitionTypeSDB,          // 4M，超清，八面体
    DefinitionTypeTDA,          // 1.5M，高清，3D八面体
    DefinitionTypeTDB,          // 4M，超清，3D八面体
};

#pragma mark - pay

/// 购买节目类型

typedef NS_ENUM(NSInteger, PurchaseProgramType) {
    
    PurchaseProgramTypeVR,                 // 单个全景节目
    PurchaseProgramTypeLive,               // 单个直播节目
    PurchaseProgramTypeCollection,         // 合集 也称专题（Topic）
    PurchaseProgramTypeTicket,             // 券
};

/// 支付商品类型

typedef NS_ENUM(NSInteger, WVRPayGoodsType) {
    
    WVRPayGoodsTypeProgram,
    WVRPayGoodsTypeProgramPackage,
    WVRPayGoodsTypeProgramAndPackage,
    WVRPayGoodsTypeFree,
};

#pragma mark - block

typedef void (^successBlock)(id sender);
typedef void (^errorBlock)(NSError *error);

/* Success data block extension */
typedef void (^successObjDataBlock)(id sender, id data);
typedef void (^successBoolDataBlock)(id sender, BOOL boolData);
typedef void (^successIntDataBlock)(id sender, NSInteger intData);
typedef void (^successFloatDataBlock)(id sender, float intData);
typedef void (^successDoubleDataBlock)(id sender, double intData);


@interface WVRAPIConst : NSObject

@end
