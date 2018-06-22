//
//  WVRParserUrlResult.m
//  VRManager
//
//  Created by Wang Tiger on 16/6/23.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRParserUrlResult.h"
#import "WVRAppConst.h"
#import "WVRAppDebugDefine.h"

@implementation WVRParserUrlResult

- (WVRParserUrlElement *)elementForDefinition:(NSString *)definition {
    for (WVRParserUrlElement *element in self.urlElementList) {
        if ([element.definition isEqualToString:definition]) {
            return element;
        }
    }
    return nil;
}

@end


@implementation WVRParserUrlElement
@synthesize definition = _definition;

#pragma mark - setter

- (void)setDefinition:(NSString *)definition {
    _definition = definition;
    
    _defiType = [WVRParserUrlElement definitionToType:definition];
    _resolution = [WVRParserUrlElement definitionToTitle:definition];
}

#pragma mark - getter

- (NSURL *)url {
    
    return _url ?: [NSURL URLWithString:@""];
}

- (NSString *)algorithm {
    
    return _algorithm ?: @"";
}

- (NSString *)definition {
    
    return _definition ?: @"";
}

+ (DefinitionType)definitionToType:(NSString *)defi {
    
    if ([defi isEqualToString:kDefinition_ST]) { return DefinitionTypeST; }
    if ([defi isEqualToString:kDefinition_SD]) { return DefinitionTypeSD; }
    if ([defi isEqualToString:kDefinition_HD]) { return DefinitionTypeHD; }
    if ([defi isEqualToString:kDefinition_XD]) { return DefinitionTypeXD; }
    if ([defi isEqualToString:kDefinition_SDA]) { return DefinitionTypeSDA; }
    if ([defi isEqualToString:kDefinition_SDB]) { return DefinitionTypeSDB; }
    if ([defi isEqualToString:kDefinition_TDA]) { return DefinitionTypeTDA; }
    if ([defi isEqualToString:kDefinition_TDB]) { return DefinitionTypeTDB; }
    if ([defi isEqualToString:kDefinition_AUTO]) { return DefinitionTypeAUTO; }
    
    DDLogError(@"definitionToType 转换未知类型: %@", defi);
    return 0;
}

+ (NSString *)definitionToTitle:(NSString *)defi {
    
    if ([defi isEqualToString:kDefinition_ST]) { return @"高清"; }
    if ([defi isEqualToString:kDefinition_SD]) { return @"超清"; }
    if ([defi isEqualToString:kDefinition_XD]) { return @"超清"; }
    if ([defi isEqualToString:kDefinition_HD]) { return @"原画"; }
    if ([defi isEqualToString:kDefinition_SDA]) { return @"高清"; }
    if ([defi isEqualToString:kDefinition_SDB]) { return @"超清"; }
    if ([defi isEqualToString:kDefinition_TDA]) { return @"超清"; }
    if ([defi isEqualToString:kDefinition_TDB]) { return @"超清"; }
    
    DDLogError(@"definitionToTitle 转换未知类型: %@", defi);
    return @"超清";
}

@end
