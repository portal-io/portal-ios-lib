//
//  UIImageView+Extend.m
//  WhaleyVR
//
//  Created by Snailvr on 16/9/1.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "UIImageView+Extend.h"

@implementation UIImageView (Extend)

- (UIImage *)compressImageWith:(UIImage *)image {
    
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    if (width == 0 || height == 0) {
        return image;
    }
    
    float scale = [UIScreen mainScreen].scale;
    
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    float widthScale;
    float heightScale;
    
    if (imageWidth > imageHeight) {     // 最小缩放比
        
        widthScale = heightScale = imageHeight /height;
    } else {
        widthScale = heightScale = imageWidth /width;
    }
    
    float finalWidth  = ceilf(imageWidth/widthScale * scale);       // 缩放过后宽高
    float finalHeight = ceilf(imageHeight/heightScale * scale);
    
    // 无需缩放
    if (finalWidth > imageWidth || finalHeight > imageHeight) { return image; }
    
    
    // 创建一个bitmap的context
    UIGraphicsBeginImageContext(CGSizeMake(finalWidth, finalHeight));
    
    [image drawInRect:CGRectMake(0, 0, finalWidth, finalHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (NSString *)transformZoomURLForString:(NSString *)url {
    
    if (url.length < 1) { return url; }
    if (self.frame.size.height == 0 || self.frame.size.width == 0) {
        return url;
    }
    
    NSMutableArray *array = [[url componentsSeparatedByString:@"/"] mutableCopy];
    
    float scale = [UIScreen mainScreen].scale;
    
    NSString *originHeight = [array lastObject];
    float imageHeight = [originHeight floatValue];
    [array removeLastObject];
    NSString *originWidth = [array lastObject];
    float imageWidth = [originWidth floatValue];
    [array removeLastObject];
    
    NSString *tmp = [array lastObject];
    if (![tmp isEqualToString:@"zoom"]) { return url; }     // 无法完成服务端缩放
    
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    float widthScale;
    float heightScale;
    
    if (imageWidth > imageHeight) {     // 最小缩放比
        
        widthScale = heightScale = imageHeight /height;
    } else {
        widthScale = heightScale = imageWidth /width;
    }
    
    float finalWidth  = ceilf(imageWidth/widthScale * scale);       // 缩放过后宽高
    float finalHeight = ceilf(imageHeight/heightScale * scale);
    
    // 无需缩放
    if (finalWidth > imageWidth || finalHeight > imageHeight) { return url; }
    
    
    long strLength = url.length - originHeight.length - originWidth.length - 1;
    NSString *prefixStr = [url substringToIndex:strLength];
    
    NSString *finalStr = [NSString stringWithFormat:@"%@%d/%d", prefixStr, (int)finalWidth, (int)finalHeight];
    
    return finalStr;
}

@end
