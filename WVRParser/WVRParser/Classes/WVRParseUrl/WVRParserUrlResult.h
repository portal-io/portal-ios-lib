//
//  WVRParserUrlResult.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/23.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRAPIConst.h"
@class WVRParserUrlElement;

@interface WVRParserUrlResult : NSObject

@property (strong, nonatomic) NSArray<WVRParserUrlElement *> *urlElementList;
@property (assign, nonatomic) BOOL isSuccessed;
@property (nonatomic, assign) BOOL haveSDA_SDB;
@property (nonatomic, assign) BOOL haveTDA_TDB;

- (WVRParserUrlElement *)elementForDefinition:(NSString *)definition;

@end


@interface WVRParserUrlElement : NSObject

/// http://127.0.0.1:12345?action
@property (strong, nonatomic) NSURL *url;
/// SD HD
@property (nonatomic, copy  ) NSString *definition;
/// oct shefere
@property (nonatomic, copy  ) NSString *algorithm;
/// enum
@property (nonatomic, assign, readonly) DefinitionType defiType;
/// 高清 超清
@property (nonatomic, copy) NSString *resolution;

@end
