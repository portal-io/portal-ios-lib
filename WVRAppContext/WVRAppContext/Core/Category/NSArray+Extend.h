//
//  NSArray+Extend.h
//  VRManager
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extend)

- (NSArray *)addOrInsteadObjectsAtIndex:(NSUInteger)index pageSize:(NSUInteger)size objects:(NSArray *)objects;

- (NSString *)toJsonString;

@end
