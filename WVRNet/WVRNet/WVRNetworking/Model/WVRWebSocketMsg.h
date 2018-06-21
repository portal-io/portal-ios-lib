//
//  WVRWebSocketMsg.h
//  WhaleyVR
//
//  Created by qbshen on 2017/5/6.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, WVRwebSocketMsgType) {
    WVRwebSocketMsgTypeNormal,
    WVRwebSocketMsgTypeManager,
    WVRwebSocketMsgTypeTop,
    WVRwebSocketMsgTypeTopDismiss,
    WVRwebSocketMsgTypeUserBannedProhibitedWords,
    WVRwebSocketMsgTypeUserBannedUNProhibitedWords,
    WVRwebSocketMsgTypeUserBannedBlacklist,
    WVRwebSocketMsgTypeUserBannedUNBlacklist,
};

@interface WVRWebSocketUserbannedMsg : NSObject

@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * duration;

@end


@interface WVRWebSocketMsg : NSObject

@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * msgId;
@property (nonatomic, strong) NSString * msgTime;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * senderNickName;
@property (nonatomic, strong) NSString * senderUid;
@property (nonatomic, assign) NSString * colorStr;

@property (nonatomic, strong) NSString * msgStayDuration;

@property (nonatomic, assign) WVRwebSocketMsgType msgType;

@property (nonatomic, strong) WVRWebSocketUserbannedMsg * userBannedMsg;

@end


