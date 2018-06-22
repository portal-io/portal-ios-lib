//
//  Security.h
//  SecurityTest
//
//  Created by chengxiyu on 15/12/11.
//  Copyright © 2015年 chengxiyu. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Security : NSObject

@property (readonly) int msdAlgid;
@property (readonly) int cdnAlgid;
@property (readonly) int p2pLiveAlgid;
@property (readonly) int userAlgid;
@property (readonly) int msdStandardAlgid;
@property (readonly) int payAlgid;

+ (Security*) getInstance;
//- (id) init;
- (BOOL) Security_Init;
- (void) Security_SetUserID : (NSString *)newUserID;
- (NSString *) Security_GetUrl : (NSString *)url WithAlgid : (int)algid;
- (NSString *) Security_Encrypt : (NSString *)text;
- (NSString *) Security_Decrypt:(NSString *)cipher;
- (NSString *) Security_Sign : (NSString *)msg WithParams : (NSString *)signParam;
- (NSString *) Security_OfflineEncrypt : (NSString *)text;
- (NSString *) Security_OfflineDecrypt : (NSString *)cipher WithIv : (NSString *)iv;
- (NSString *) Security_StandardEncrypt : (NSString *)text withAlgid: (int) algid;
- (NSString *) Security_StandardDecrypt : (NSString *)cipher withAlgid : (int) algid;

@end
