//
//  QMUIButton+Factory.h
//  MagicMiss
//
//  Created by jiasong on 2019/4/29.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "QMUIButton.h"

typedef NS_ENUM(NSUInteger, QMUIButtonFactoryType) {
    QMUIButtonFactoryTypeNormal,
};


NS_ASSUME_NONNULL_BEGIN

@interface QMUIButton (Factory)

+(QMUIButton *)factory_buttonType:(QMUIButtonFactoryType)factoryType;

@end

NS_ASSUME_NONNULL_END
