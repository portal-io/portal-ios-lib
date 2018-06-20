//
//  WVRAppModel.h
//  VRManager
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 Snailvr. All rights reserved.

// 应用基本数据 单例

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WVRAppModel : NSObject

//@property (nonatomic, assign) BOOL          playerGuildStatu;       // 新手指引
@property (nonatomic, readonly) NSDictionary *commenParams;
/// 存储直播试看时间数据
@property (nonatomic, readonly) NSMutableDictionary *liveTrailDict;

@property (nonatomic, readonly) float     widthFit;

/// 此处获取的值在app生命周期内不会变，仅作为特殊用途
@property (nonatomic, readonly) NSString *ipAdress;

/// 下行数据量（每秒取一次值）
@property (nonatomic, assign) long tmpDownSize;
@property (nonatomic, readonly) long curDownSize;

// MARK: - cell宽高
@property (nonatomic, readonly) float     normalItemWidth;
@property (nonatomic, readonly) float     normalItemHeight;

@property (nonatomic, readonly) float     movieItemWidth;
@property (nonatomic, readonly) float     movieItemHeight;

@property (nonatomic, readonly) float     recommendCellHeight;

@property (nonatomic, assign) BOOL shouldContinuePlay;

@property (nonatomic, assign) BOOL preVcisOrientationPortraitl;

// 足球首次引导
@property (nonatomic, assign) BOOL footballCameraTipIsShow;

/// 单例
+ (instancetype)sharedInstance;

- (void)saveLiveTrailDict;

/// 字体适配
+ (float)fontSizeForPx:(float)px;
+ (UIFont *)fontFitForSize:(float)size;
+ (UIFont *)boldFontFitForSize:(float)size;

/// 强制设置屏幕方向
+ (void)forceToOrientation:(UIInterfaceOrientation)orientation;

/// 设置状态栏方向（协助控制App方向）
+ (void)changeStatusBarOrientation:(UIInterfaceOrientation)orientation;

/// 设置状态栏方向（协助控制App方向）
+ (void)changeStatusBarOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animate;

#pragma mark - request

//srcCode   节目（直播,资讯）code   必填
//programType 节目类型，支持 live（直播）, recorded（视频）, webpage（资讯） 必填
//videoType 视频格式，支持 2d，3d，vr (资讯类型不必填）
//type：上报类型，支持 view（浏览），play（播放），timelong（时长） 必填
//sec：观看时长（可选，类型为timelong时才必须有，单位秒）
//title：标题（可选，webpage类型必填

//+ (void)uploadViewInfoWithCode:(NSString *)srcCode programType:(NSString *)programType videoType:(NSString *)videoType type:(NSString *)type sec:(NSString *)sec title:(NSString *)title;

/// 检测下行流量速度 byte
- (long)checkInNetworkflow;

//+ (void)logReport:(NSString *)msg;

@end
