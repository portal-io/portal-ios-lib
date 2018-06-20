//
//  WVRAppFontDefine.h
//  WVRAppContext
//
//  Created by qbshen on 2017/8/8.
//  Copyright © 2017年 WhaleyVR. All rights reserved.
//

#ifndef WVRAppFontDefine_h
#define WVRAppFontDefine_h



/********************     Font       ********************/

#define kFontFitForPx(px)       [WVRAppModel fontFitForPx:px]
#define kFontFitForSize(size)   [WVRAppModel fontFitForSize:size]
#define kBoldFontFitSize(size)  [WVRAppModel boldFontFitForSize:size]
#define kNavTitleFont           [UIFont systemFontOfSize:19.f]
#define kNavLeftBarFont         [UIFont systemFontOfSize:18.f]

//默认字体
#define FONT(fSize)             [UIFont systemFontOfSize:fSize]
#define BOLD_FONT(fSize)        [UIFont boldSystemFontOfSize:fSize]


#endif /* WVRAppFontDefine_h */
