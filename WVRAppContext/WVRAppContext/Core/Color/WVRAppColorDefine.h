//
//  WVRAppColorDefine.h
//  WVRAppContext
//
//  Created by qbshen on 2017/8/8.
//  Copyright © 2017年 WhaleyVR. All rights reserved.
//

#ifndef WVRAppColorDefine_h
#define WVRAppColorDefine_h

/**********************  UI  Colors  ********************/

#define k_Color_hex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1]

// 最新色值对照 从安卓2.5.5启用
#define k_Color1                   k_Color_hex(0x29A1F7)
#define k_Color2                   k_Color_hex(0x000000)
#define k_Color3                   k_Color_hex(0x333333)
#define k_Color4                   k_Color_hex(0x666666)
#define k_Color5                   k_Color_hex(0x888888)
#define k_Color6                   k_Color_hex(0x999999)
#define k_Color7                   k_Color_hex(0xB4B4B4)
#define k_Color8                   k_Color_hex(0xC8C8C8)
#define k_Color9                   k_Color_hex(0xDCDCDC)
#define k_Color10                  k_Color_hex(0xF0F0F0)
#define k_Color11                  k_Color_hex(0xF5F5F5)
#define k_Color12                  k_Color_hex(0xFFFFFF)
#define k_Color13                  k_Color_hex(0x0881D7)
#define k_Color14                  k_Color_hex(0xF7D154)
#define k_Color15                  k_Color_hex(0xFF3E3E)
#define k_Color16                  k_Color_hex(0x96D66B)
#define k_Color17                  k_Color_hex(0xFAFAFA)
#define k_Color18                  k_Color_hex(0x0CE88C)
#define k_Color19                  k_Color_hex(0xE43B3B)
#define k_Color20                  k_Color_hex(0xFF7900)

#define Color_RGB(r, g, b)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define Color_RGBA(R, G, B, a)     [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:a]

#define kLineBGColor            [UIColor colorWithRed:235/255.0 green:239/255.0 blue:242/255.0 alpha:1]



#endif /* WVRAppColorDefine_h */
