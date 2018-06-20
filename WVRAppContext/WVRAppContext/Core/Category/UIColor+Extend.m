//
//  UIColor+Extend.m
//  VRManager
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "UIColor+Extend.h"


// Color algorithms from http://www.cs.rit.edu/~ncs/color/t_convert.html

#define MAX3(a, b, c) (a > b ? (a > c ? a : c) : (b > c ? b : c))
#define MIN3(a, b, c) (a < b ? (a < c ? a : c) : (b < c ? b : c))

void RGBtoHSV(float r, float g, float b, float* h, float* s, float* v) {
    float min, max, delta;
    min = MIN3(r, g, b);
    max = MAX3(r, g, b);
    *v = max;				// v
    delta = max - min;
    if( max != 0 )
        *s = delta / max;		// s
    else {
        // r = g = b = 0		// s = 0, v is undefined
        *s = 0;
        *h = -1;
        return;
    }
    if( r == max )
        *h = ( g - b ) / delta;		// between yellow & magenta
    else if( g == max )
        *h = 2 + ( b - r ) / delta;	// between cyan & yellow
    else
        *h = 4 + ( r - g ) / delta;	// between magenta & cyan
    *h *= 60;				// degrees
    if( *h < 0 )
        *h += 360;
}

void HSVtoRGB( float *r, float *g, float *b, float h, float s, float v )
{
    int i;
    float f, p, q, t;
    if( s == 0 ) {
        // achromatic (grey)
        *r = *g = *b = v;
        return;
    }
    h /= 60;			// sector 0 to 5
    i = floor( h );
    f = h - i;			// factorial part of h
    p = v * ( 1 - s );
    q = v * ( 1 - s * f );
    t = v * ( 1 - s * ( 1 - f ) );
    switch( i ) {
        case 0:
            *r = v;
            *g = t;
            *b = p;
            break;
        case 1:
            *r = q;
            *g = v;
            *b = p;
            break;
        case 2:
            *r = p;
            *g = v;
            *b = t;
            break;
        case 3:
            *r = p;
            *g = q;
            *b = v;
            break;
        case 4:
            *r = t;
            *g = p;
            *b = v;
            break;
        default:		// case 5:
            *r = v;
            *g = p;
            *b = q;
            break;
    }
}


@implementation UIColor (Extend)

// 16进制颜色
+ (UIColor *)colorWithHex:(NSUInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor *)colorWithHex:(NSUInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}


+ (NSString *)hexFromUIColor:(UIColor *)color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}


/// 获取UIImage对象的主色调
+ (UIColor *)mostColorInImage:(UIImage*)image {
    
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,                 //bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    NSArray *MaxColor = nil;
    // NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    float maxScore=0;
    for (int x=0; x<thumbSize.width*thumbSize.height; x++) {
        
        int offset = 4*x;
        
        int red = data[offset];
        int green = data[offset+1];
        int blue = data[offset+2];
        int alpha =  data[offset+3];
        
        if (alpha<25)continue;
        
        float h,s,v;
        RGBtoHSV(red, green, blue, &h, &s, &v);
        
        float y = MIN(abs(red*2104 + green*4130 + blue*802 + 4096 + 131072)>>13, 235);
        y= (y-16)/(235-16);
        if (y>0.9) continue;
        
        float score = (s+0.1)*x;
        if (score>maxScore) {
            maxScore = score;
        }
        MaxColor = @[ @(red), @(green), @(blue), @(alpha) ];
        //        [cls addObject:clr];
    }
    CGContextRelease(context);
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

// 详情页取色，图片上半部分主色调
+ (UIColor *)mostColorInImageTop:(UIImage *)image {
    
    CGImageRef cgRef = image.CGImage;
    CGImageRef imageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(0, 0, image.size.width, image.size.height/10.0));
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    UIColor *color = [UIColor mostColorInImage:newImage];
    
    return color;
}

@end
