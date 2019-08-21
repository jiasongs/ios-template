//
//  Theme.m
//  MagicMiss
//
//  Created by jiasong on 2019/4/22.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ThemeManager.h"
#import "QMUIConfigurationTemplate.h"

@implementation ThemeManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ThemeManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (instancetype)init {
    self = [super init];
    if (self) {
       
    }
    return self;
}

@end
