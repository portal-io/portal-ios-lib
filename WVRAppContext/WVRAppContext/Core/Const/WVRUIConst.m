//
//  WVRUIConst.m
//  WhaleyVR
//
//  Created by Snailvr on 16/7/22.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *const kAppBannerId = @"kAppBannerId";


/**
 *  后端返回 渲染类型
 */
NSString *const RENDER_TYPE_SPHERE = @"sphere";
NSString *const RENDER_TYPE_OCTAHEDRAL = @"octahedral";
NSString *const RENDER_TYPE_360_2D = @"360_2D";
NSString *const RENDER_TYPE_360_2D_OCTAHEDRAL = @"360_2D_OCTAHEDRAL";
NSString *const RENDER_TYPE_PLANE_2D = @"PLANE_2D";
NSString *const RENDER_TYPE_PLANE_3D_LR = @"PLANE_3D_LR";
NSString *const RENDER_TYPE_PLANE_3D_UD = @"PLANE_3D_UD";
NSString *const RENDER_TYPE_360_3D_LF = @"360_3D_LF";
NSString *const RENDER_TYPE_360_3D_UD = @"360_3D_UD";
NSString *const RENDER_TYPE_180_PLANE = @"180_PLANE";
NSString *const RENDER_TYPE_180_3D_UD = @"180_3D_UD";
NSString *const RENDER_TYPE_180_3D_LF = @"180_3D_LF";
NSString *const RENDER_TYPE_360_OCT_3D = @"360_OCT_3D";
NSString *const RENDER_TYPE_180_3D_OCT = @"180_OCT_3D";


/*
 高清 ST 超清SD 原画HD
 */

NSString *const kDefinition_ST = @"ST";         // 高清，2k球面
NSString *const kDefinition_SD = @"SD";         // 超清，2k八面体
NSString *const kDefinition_HD = @"HD";         // 4k，4k球面
NSString *const kDefinition_AUTO = @"AUTO";     //
NSString *const kDefinition_XD = @"XD";         // 蓝光，电视剧专有
NSString *const kDefinition_SDA = @"SDA";       // 1.5M，高清，八面体
NSString *const kDefinition_SDB = @"SDB";       // 4M，超清，八面体
NSString *const kDefinition_TDA = @"TDA";       // 超清，3D八面体
NSString *const kDefinition_TDB = @"TDB";       // 超清，3D八面体


#import "WVRUIConst.h"

@implementation WVRUIConst

@end


