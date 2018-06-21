//
//  WVRPostRequest.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRBaseRequest.h"
#import "WVRRequestProtocol.h"
#import "WVRRequestPage.h"

typedef void (^onComplete)(id complete);
typedef void (^onSuccessed)(id successData);
typedef void (^onFailed)(id failedData);

@interface WVRBaseFileRequest : WVRBaseRequest<WVRRequestProtocol>

@property (nonatomic) NSString *keyName;
@property (nonatomic) NSString *fileName;
@property (nonatomic) NSString *filePath;
@property (nonatomic) NSData *fileData;
@property (nonatomic) NSMutableArray * fileDatas;

@property (nonatomic) id originResponse;
@property (nonatomic) WVRRequestPage *page;
@property (nonatomic, copy) onSuccessed successedBlock;
@property (nonatomic, copy) onFailed failedBlock;

- (NSDictionary *)getBodyParam;

@end
