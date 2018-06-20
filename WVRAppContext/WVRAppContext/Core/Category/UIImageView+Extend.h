//
//  UIImageView+Extend.h
//  WhaleyVR
//
//  Created by Snailvr on 16/9/1.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extend)

/// compress iamge for imageView.size
- (UIImage *)compressImageWith:(UIImage *)image;

/// new CDN api zoom iamge
- (NSString *)transformZoomURLForString:(NSString *)url;

@end
