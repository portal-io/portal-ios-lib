//
//  UIImage+Extend.m
//  VRManager
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

- (UIImage *)clips:(float)cornerRadius {
    
    CGFloat w = self.size.width;
    
    CGFloat h = self.size.height;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    // 防止圆角半径小于0，或者大于宽/高中较小值的一半。
    if (cornerRadius < 0) {
        cornerRadius = 0;
    } else if (cornerRadius > MIN(w, h)) {
        cornerRadius = MIN(w, h) / 2.f;
    }
    
    UIImage *image = nil;
    
    CGRect imageFrame = CGRectMake(0, 0, w, h);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:cornerRadius] addClip];
    
    [self drawInRect:imageFrame];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    float scale = [UIScreen mainScreen].scale;
    CGSize finalSize = CGSizeMake(size.width * scale, size.height * scale);
    
    UIGraphicsBeginImageContext(finalSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, finalSize.width, finalSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame {
    
    float scale = [UIScreen mainScreen].scale;
    CGRect finalFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * scale, frame.size.height * scale);
    
    UIGraphicsBeginImageContext(finalFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, finalFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)roundImageWithColor:(UIColor *)color frame:(CGRect)frame cornerRadius:(float)corner {
    
//    float scale = [[UIScreen mainScreen] scale];
//    CGSize size = CGSizeMake(frame.size.width * scale, frame.size.height * scale);
    
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    [[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:corner] addClip];
    [img drawInRect:frame];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)roundImageWithFrame:(CGRect)frame cornerRadius:(float)corner {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:corner] addClip];
    [self drawInRect:frame];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageCompressWithSimple:(UIImage *)image scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageCompressWithSimple:(UIImage *)image scale:(float)scale
{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 按照控件（imageView）尺寸缩放图片
- (UIImage *)compresstoSize:(CGSize)size
{
    float scale = [UIScreen mainScreen].scale;
    
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    
    float width = size.width;
    float height = size.height;
    
    float widthScale;
    float heightScale;
    
    if (imageWidth > imageHeight) {     // 最小缩放比
        
        widthScale = heightScale = imageHeight /height;
    } else {
        widthScale = heightScale = imageWidth /width;
    }
    
    float finalWidth  = ceilf(imageWidth/widthScale * scale);       // 缩放过后宽高
    float finalHeight = ceilf(imageHeight/heightScale * scale);
    
    
    if (finalWidth > imageWidth || finalHeight > imageHeight) {     // 无需缩放
        return self;
    }
    
    // 创建一个bitmap的context
    UIGraphicsBeginImageContext(CGSizeMake(finalWidth, finalHeight));
    
    [self drawInRect:CGRectMake(0, 0, finalWidth, finalHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
