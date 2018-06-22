//
//  LWSQLiteManager.h
//  LewoSVR
//
//  Created by iStig on 15/11/11.
//  Copyright © 2015年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabaseQueue;

#define kDownloadPath [NSString pathWithComponents:@[[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject], @"videos"]] // 视频下载默认文件路径


@interface WVRSQLiteManager : NSObject

@property (nonatomic, readonly, copy  ) NSString *databasePath;
@property (nonatomic, readonly, strong) FMDatabaseQueue *fmQueue;

@property (nonatomic, assign, readonly) long maxEventId;

+ (instancetype)sharedManager;


#pragma mark - 苹果内购订单防止漏单管理

- (BOOL)insertIAPOrder:(NSDictionary *)modelDict;

- (NSArray<NSDictionary *> *)ordersInIAPOrder;

- (void)removeIAPOrder:(NSString *)videoId;

- (void)removeAllIAPOrder;


#pragma mark - BI Event Track

- (BOOL)insertBIEvent:(NSString *)content;

/**
 SQLite中存储的BI数据
 
 @return 存储BI JSON数据的数组
 */
- (NSArray *)contentsInBIEvents;

/**
 上报成功，移除SQLite中的数据

 @param Id 默认传0即可，自动匹配contentsInBIEvents时的maxId
 */
- (void)removeBIEventBelowId:(long)Id;

- (void)removeAllBIEvents;

@end
