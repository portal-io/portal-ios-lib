//
//  UIButton+Extends.m
//  VRManager
//
//  Created by Snailvr on 16/7/11.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "UIButton+Extends.h"

@implementation UIButton(UIButtonExt)

- (void)centerImageAndTitle:(float)spacing {
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    NSDictionary *fontDict = [NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil];
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:fontDict];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0, 0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

- (void)rightImageLeftTitle:(float)spacing {
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    NSDictionary *fontDict = [NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil];
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:fontDict];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalWidth = (imageSize.width + titleSize.width + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - titleSize.width-totalWidth);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, 0, 0);
}

- (void)centerImageAndTitle
{
    const int DEFAULT_SPACING = 6.0f;
    
    [self centerImageAndTitle:DEFAULT_SPACING];
}

- (void)setBackgroundImageWithColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
