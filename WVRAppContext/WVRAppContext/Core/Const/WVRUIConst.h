//
//  WVRUIConst.h
//  WhaleyVR
//
//  Created by Snailvr on 16/7/22.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 Tab控制器展示顺序
 */
typedef NS_ENUM(NSInteger, kTabBarIndex) {
    
    kFindTabBarIndex = 0,           // 首页
    kLiveTabBarIndex,               // 直播
//#if (kAppEnvironmentLauncher == 1)
//    kLauncherTabBarIndex,           // U3D
//#endif
    kRecommendTabBarIndex,          // 关注
    kAccountTabBarIndex,            // 我的
};

/**
 *  后端返回 渲染类型
 */
extern NSString *const RENDER_TYPE_SPHERE;
extern NSString *const RENDER_TYPE_OCTAHEDRAL;
extern NSString *const RENDER_TYPE_360_2D;
extern NSString *const RENDER_TYPE_360_2D_OCTAHEDRAL;
extern NSString *const RENDER_TYPE_PLANE_2D;
extern NSString *const RENDER_TYPE_PLANE_3D_LR;
extern NSString *const RENDER_TYPE_PLANE_3D_UD;
extern NSString *const RENDER_TYPE_360_3D_LF;
extern NSString *const RENDER_TYPE_360_3D_UD;
extern NSString *const RENDER_TYPE_180_PLANE;
extern NSString *const RENDER_TYPE_180_3D_UD;
extern NSString *const RENDER_TYPE_180_3D_LF;
extern NSString *const RENDER_TYPE_360_OCT_3D;
extern NSString *const RENDER_TYPE_180_3D_OCT;


/// 高清，2k球面
extern NSString *const kDefinition_ST;
/// 超清，2k八面体
extern NSString *const kDefinition_SD;
/// 4k，4k球面
extern NSString *const kDefinition_HD;
/// auto, 暂时未用到
extern NSString *const kDefinition_AUTO;
/// 蓝光，电视剧专有
extern NSString *const kDefinition_XD;
/// 1.5M，高清，八面体
extern NSString *const kDefinition_SDA;
/// 4M，超清，八面体
extern NSString *const kDefinition_SDB;
/// 超清，3D八面体
extern NSString *const kDefinition_TDA;
/// 超清，3D八面体
extern NSString *const kDefinition_TDB;

@interface WVRUIConst : NSObject

@end
