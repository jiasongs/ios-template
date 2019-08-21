//
//  QMUIButton+Factory.m
//  MagicMiss
//
//  Created by jiasong on 2019/4/29.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "QMUIButton+Factory.h"

@implementation QMUIButton (Factory)

+(QMUIButton *)factory_buttonType:(QMUIButtonFactoryType)factoryType {
    QMUIButton *button = [[QMUIButton alloc] init];
    if (factoryType == QMUIButtonFactoryTypeNormal) {
        [button setTitleColor:UIColorMakeWithHex(@"#333333") forState:UIControlStateNormal];
        [button.titleLabel setFont:UIFontMake(15)];
    }
    return button;
}



@end
