//
//  NotificationHeader.h
//  WhaleyVR
//
//  Created by qbshen on 2017/3/8.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#ifndef NotificationHeader_h
#define NotificationHeader_h

/********************    ReuseId     ********************/

#define kSeparateLineId         @"kSeparateLineId"
#define kCollectionReuseId      @"kCollectionReuseId"


/********************   image  Name  ********************/

#define HOLDER_IMAGE            [UIImage imageNamed:@"defaulf_holder_image"]


/********************     通知中心    ********************/

#define kNetStatusChagedNoti                 @"kNetStatusChagedNoti"        // 网络状态改变
#define kNetReachableNotification            @"kNetReachableNotification"   // 无网变有网
#define kNetReachNotification                @"kNetReachNotification"       // WIFI变移动网
#define kNoNetNotification                   @"kNoNetNotification"          // 断网
#define kWebShareDoneNotification            @"kWebShareDoneNotification"   // H5分享完成
// 登录状态变更 通知  { @"status" : @0 }      0表示注销登录，1表示登录成功
#define kLoginStatusNotification             @"kLoginSuccessNotification"
// 关注状态变更 { @"cpCode" : @"code", @"isFollow": @0 }    0表示取消关注，1表示关注成功
#define kAttentionStatusNoti                 @"kAttentionStatusNoti"

#define kUpdateScreenLockStatusNoti          @"kUpdateScreenLockStatusNoti"
// 购买（兑换）成功后的通知
#define kBuySuccessNoti                      @"kBuySuccessNoti"

/**********************   JPush推送    ********************/

#define pAppKey                 @"585d3b8423a931fd4550495b"


#define NAME_NOTF_RESERVE_PRESENTER_REFRESH (@"NAME_NOTF_RESERVE_PRESENTER_REFRESH")

#define NAME_NOTF_HISTORY_REFRESH (@"NAME_NOTF_HISTORY_REFRESH")

#define NAME_NOTF_RELOAD_PLAYER (@"NAME_NOTF_RELOAD_PLAYER")

#define NAME_NOTF_LIVE_TAB_RELOAD_PLAYER (@"NAME_NOTF_LIVE_TAB_RELOAD_PLAYER")

#define NAME_NOTF_MANUAL_ARRANGE_SHARE (@"NAME_NOTF_MANUAL_ARRANGE_SHARE")

#define NAME_NOTF_MANUAL_ARRANGE_PROGRAMPACKAGE (@"NAME_NOTF_MANUAL_ARRANGE_PROGRAMPACKAGE")

#define NAME_NOTF_LAYOUTSUBVIEWS_LIVE_RECOMMEND (@"NAME_NOTF_LAYOUTSUBVIEWS_LIVE_RECOMMEND")

#define NAME_NOTF_CLEAR_REWARD_DOT (@"NAME_NOTF_CLEAR_REWARD_DOT")

#define NAME_NOTF_HANDLE_JPUSH_NOT (@"NAME_NOTF_HANDLE_JPUSH_NOT")

#define NAME_NOTF_PLAYER_ISRELASE_COMPLETE (@"NAME_NOTF_PLAYER_ISRELASE_COMPLETE")

#endif /* NotificationHeader_h */
