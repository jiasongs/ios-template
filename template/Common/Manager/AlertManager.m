//
//  AlertManager.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

+(void)showCustomView:(UIView *)customView {
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.contentView = customView;
    [modalViewController showWithAnimated:YES completion:nil];
}

+(void)showTitle:(NSString *)title
         message:(NSString *)message
       configure:(nullable AlertConfigure)configure {
    [self alertControllerWithTitle:title
                           message:message
                       actionTitle:nil
                       cancelTitle:nil
                         configure:^(QMUIAlertController *alertVC) {
                             alertVC.shouldRespondMaskViewTouch = YES;
                             if (configure) {
                                 configure(alertVC);
                             }
                         } handler:nil];
}

+(void)showTitle:(NSString *)title
         message:(NSString *)message
     actionTitle:(NSString *)actionTitle
       configure:(nullable AlertConfigure)configure
         handler:(nullable AlertHandler)handler {
    [self alertControllerWithTitle:title message:message actionTitle:actionTitle cancelTitle:nil configure:configure handler:handler];
}

+(void)showTitle:(NSString *)title
         message:(NSString *)message
     actionTitle:(NSString *)actionTitle
     cancelTitle:(NSString *)cancelTitle
       configure:(nullable AlertConfigure)configure
         handler:(nullable AlertHandler)handler {
    [self alertControllerWithTitle:title message:message actionTitle:actionTitle cancelTitle:cancelTitle configure:configure handler:handler];
}

+(void)alertControllerWithTitle:(NSString *)title
                                         message:(NSString *)message
                                     actionTitle:(nullable NSString *)actionTitle
                                     cancelTitle:(nullable NSString *)cancelTitle
                                       configure:(nullable AlertConfigure)configure
                                         handler:(nullable AlertHandler)handler {
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:title message:message preferredStyle:QMUIAlertControllerStyleAlert];
    if (actionTitle && actionTitle.length > 0) {
        [alertController addAction:[QMUIAlertAction actionWithTitle:actionTitle style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
            if (handler) {
                handler(aAlertController, action);
            }
        }]];
    }
    if (cancelTitle && cancelTitle.length > 0) {
        [alertController addAction:[QMUIAlertAction actionWithTitle:cancelTitle style:QMUIAlertActionStyleCancel handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
            if (handler) {
                handler(aAlertController, action);
            }
        }]];
    }
    if (configure) {
        configure(alertController);
    }
    [alertController showWithAnimated:YES];
}




@end

