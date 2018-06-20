//
//  NSArray+Extend.m
//  VRManager
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "NSArray+Extend.h"

@implementation NSArray (Extend)

// warning  self不能等于nil  size是从1算起，传0自动拼接到最后一页
- (NSArray *)addOrInsteadObjectsAtIndex:(NSUInteger)index pageSize:(NSUInteger)size objects:(NSArray *)objects {
    
    if (index <= 0) {
        index = self.count/size + 1;        // 传0自动拼接到最后一页
    }
    
    if (self.count < (index-1) * size) {                  // count太少，不足以拼接
        NSLog(@"error: Array's count is too less");
        return self;
    }
    
    NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self];
    
    NSInteger num = (index-1) * size;
    if (self.count < (index * size - 1)) {
        for (id object in objects) {
            if (num < self.count) {
                [tmpArray replaceObjectAtIndex:num withObject:object];
                
            } else {
                [tmpArray addObject:object];
            }
            num += 1;
        }
        
        return [tmpArray copy];
    }
    // 0-39  18-35
    // self.count >= (index * size - 1)
    for (id object in objects) {
        
        [tmpArray replaceObjectAtIndex:num withObject:object];
        num += 1;
    }
    
    return [tmpArray copy];
}

- (NSString *)toJsonString {
    
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (error) { return nil; }
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

@end
