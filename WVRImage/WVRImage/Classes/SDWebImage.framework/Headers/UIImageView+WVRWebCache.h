//
//  UIImageView+WVRWebCache.h
//  WhaleyVR
//
//  Created by Bruce on 2017/5/4.
//  Copyright © 2017年 Snailvr. All rights reserved.

// WhaleyVR基于SDWebImage的封装，注意：SDWebImageRefreshCached选项经过测试我们的后台服务器不支持，所以这个选项最好不要用

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImageManager.h>

typedef void(^SD_WebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL * targetURL);

typedef void(^SD_ExternalCompletionBlock)(UIImage * image, NSError * error, NSInteger cacheType, NSURL * imageURL);


@interface UIImageView (WVRWebCache)

extern void wvr_configSDWebImage(void);

- (void)wvr_setImageWithURL:(NSURL *)url;

- (void)wvr_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)wvr_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                   options:(SDWebImageOptions)options;

- (void)wvr_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                 completed:(SD_ExternalCompletionBlock)completedBlock;

- (void)wvr_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                   options:(SDWebImageOptions)options
                 completed:(SD_ExternalCompletionBlock)completedBlock;

- (void)wvr_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(SDWebImageOptions)options
                   progress:(SD_WebImageDownloaderProgressBlock)progressBlock
                  completed:(SD_ExternalCompletionBlock)completedBlock;

#pragma mark - WVRImage

/**
 配合蘑菇云CDN使用，带zoom的URL链接配合imageView大小转换

 @param url 从后端获取的图片链接
 @return 转换大小后的图片链接
 */
- (NSString *)wvr_transformZoomURLForString:(NSString *)url;

/**
 配合蘑菇云CDN使用，带zoom的URL链接配合imageView大小转换
 
 @param url 从后端获取的图片链接
 @param scale 将图片按imageView的frame匹配后，再按比例缩放
 @return 转换大小后的图片链接
 */
- (NSString *)wvr_transformZoomURLForString:(NSString *)url scale:(float)scale;

@end
