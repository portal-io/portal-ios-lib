//
//  WVRAPIConst.m
//  VRManager
//
//  Created by Snailvr on 16/6/23.
//  Copyright © 2016年 Snailvr. All rights reserved.


#import "WVRAPIConst.h"

@implementation WVRAPIConst

@end

// 定义通用型的block，全局常量，枚举等

#pragma mark - key 

NSString * const TEST_USER_HISTORY_SIGN_SECRET = @"5d40190e25c04495bb920abe34d16a98caeb903a56e14b1d8c578f6ae8834c77750d76d4c21545e99abb952fb13603e7c8620099e2e74d3aa6863a4fe091d03f";
NSString * const USER_HISTORY_SIGN_SECRET = @"e0dfa6491c3e4976b96feb3ad93112dc06e219b08f7f49148c2cf78ea451a3e1468dcd62bdcd435d9ce290290c8bdba68ce17124c6f94ff0a53bbf46110d26ca";

NSString * const TEST_USER_PURCHASE_SIGN_SECRET = @"5d40190e25c04495bb920abe34d16a98caeb903a56e14b1d8c578f6ae8834c77750d76d4c21545e99abb952fb13603e7c8620099e2e74d3aa6863a4fe091w2q8";
NSString * const USER_PURCHASE_SIGN_SECRET = @"hvxhb2jr2t726x22156v5xdv476lvdd3tf3hn081d133np52r725tf2z132zvzp4j8p5567x32l3pnr7przntl5d14db602l97px23dx1f9hv37v0zl1x69b3hb4r56f";
#pragma mark - toast text

NSString *const kAlertTitle  = @"提示";
NSString *const kToastShow   = @"主播正在赶来的路上";
NSString *const kNoMoreData  = @"已无更多数据";
NSString *const kNetError    = @"请检查网络连接";
NSString *const kPlayError   = @"播放失败，请稍后重试";
NSString *const kLoadError   = @"网络加载失败";
NSString *const kLinkError   = @"链接解析失败";
NSString *const kReloadData  = @"重新加载";
NSString *const kNoNetAlert  = @"无网络连接，请检查网络";
NSString *const kReachAlert  = @"您正在使用移动网络，继续使用将会产生流量费用，是否继续?";

NSString *const kToastLiveOver = @"直播已结束";
NSString *const kToastProgramInvalid = @"该节目已失效";
NSString *const kToastChargeLottery = @"试看时不能参与抽奖活动";
NSString *const kToastChargeDanmu = @"试看时不支持发送弹幕";
NSString *const kToastCollectionSuccess = @"加入播单成功";
NSString *const kToastCollectionFail = @"加入播单失败";
NSString *const kToastCancelCollectionSuccess = @"移除播单成功";
NSString *const kToastCancelCollectionFail = @"移除播单失败";
NSString *const kToastNotChargeToUnity = @"未购买暂不支持分屏模式，请购买后再试";

NSString *const kToastAttentionSuccess = @"关注成功！";
NSString *const kToastAttentionFail = @"关注失败，请稍后重试";
NSString *const kToastCancelAttentionSuccess = @"取消关注成功！";
NSString *const kToastCancelAttentionFail = @"取消关注失败，请稍后重试";

NSString *const kToastNoChangeDefinition = @"当前片源没有可切换的清晰度";

#pragma mark - API 

NSString *const kAPI_PLATFORM = @"ios";

NSString *const kAPI_SERVICE = @"newVR-service/appservice/";

CGFloat const kHTTPPageSize  = 18.f;   // 此处Float类型请勿修改，值可以改

CGFloat const kHideToolBarTime = 9.f;


// WhaleyVR账户体系接口
NSString *const kAPI_WHALEY_ACCOUNT_BASE_URL = @"https://account.whaley.cn/";

// newVR接口
NSString *const kAPI_NEW_VR_BASE_URL_TEST = @"https://vrtest-api.aginomoto.com/";
NSString *const kAPI_NEW_VR_BASE_URL_ONLINE = @"https://vr-api.aginomoto.com/";

// sotreapi接口
NSString *const kAPI_STORE_BASE_URL_TEST = @"http://storeapi.test.snailvr.com/";
NSString *const kAPI_STORE_BASE_URL_ONLINE = @"http://storeapi.snailvr.com/";

// BI埋点
NSString *const kAPI_WHALEY_BI_BASE_URL_ONLINE = @"http://vrlog.aginomoto.com/vrapplog";
NSString *const kAPI_WHALEY_BI_BASE_URL_TEST = @"http://test-wlslog.aginomoto.com/vrapplog";

// 消息
NSString *const kAPI_WHALEY_BUS_BASE_URL = @"http://bus.aginomoto.com/";

NSString *const kAPI_SNAILVR_BASE_URL_DEV = @"http://vrapi-dev.snailvr.com/";
NSString *const kAPI_SNAILVR_BASE_URL_TEST = @"http://vrapi-test.snailvr.com/";
NSString *const kAPI_SNAILVR_BASE_URL_ONLINE = @"http://vrapi.snailvr.com/";


