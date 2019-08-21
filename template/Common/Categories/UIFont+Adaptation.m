//
//  UIFont+Adaptation.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/12.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "UIFont+Adaptation.h"


@implementation UIFont (Adaptation)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(systemFontOfSize:),
            @selector(boldSystemFontOfSize:),
        };
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"adaptation_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            Method originalMethod = class_getClassMethod(self, originalSelector);
            Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

+ (UIFont *)adaptation_systemFontOfSize:(CGFloat)fontSize {
    CGFloat adaptationFontSize = IS_IPAD ? fontSize : ceil(ScaleSize(fontSize));
    return [UIFont adaptation_systemFontOfSize:adaptationFontSize];
}

+ (UIFont *)adaptation_boldSystemFontOfSize:(CGFloat)fontSize {
    CGFloat adaptationFontSize = IS_IPAD ? fontSize : ceil(ScaleSize(fontSize));
    return [UIFont adaptation_boldSystemFontOfSize:adaptationFontSize];
}


@end
