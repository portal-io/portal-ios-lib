//
//  WVRVideoModel.h
//  WhaleyVR
//
//  Created by qbshen on 16/11/4.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger , WVRVideoDownloadStatus){
    WVRVideoDownloadStatusDefault = 0,
    WVRVideoDownloadStatusDowning,
    WVRVideoDownloadStatusPause,
    WVRVideoDownloadStatusDown,
    WVRVideoDownloadStatusDownFail,
    WVRVideoDownloadStatusPrepare,
};

@interface WVRVideoModel : NSObject

@property (nonatomic) NSString *uuid;

@property (nonatomic, assign) long createTime;

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* itemId;
@property (nonatomic) NSString* intrDesc;
@property (nonatomic) NSString* videoType;
@property (nonatomic) NSString* subTitle;

@property (nonatomic) NSInteger renderType;
@property (nonatomic) NSInteger streamType;
//@property (nonatomic) FrameOritation oritation;
/**
 down video
 */
@property (nonatomic) BOOL isDownload;
@property (nonatomic) BOOL downloadOver;
@property (nonatomic) WVRVideoDownloadStatus downStatus;
@property (nonatomic) NSString* thubImage;

@property (nonatomic) NSString * scaleThubImage;
@property (nonatomic) NSString* pathToFile;
@property (nonatomic) NSString * fileName;
@property (nonatomic) NSString* downLink;
@property (nonatomic) CGFloat downProgress;

@property (nonatomic) NSInteger duration;
@property (nonatomic) CGFloat totalSize;
@property (nonatomic) NSString* curSize;

/**
 local video
 */
@property (nonatomic) UIImage* localThubImage;
@property (nonatomic) NSString* localUrl;

- (BOOL)save;
- (void)deleteWithItemId:(NSString*)itemId;

+ (WVRVideoModel*)loadFromDBWithId:(NSString*)itemId;
+ (NSArray*)searchAllFromDBWithDownFlag:(BOOL)downFlag;


@end
