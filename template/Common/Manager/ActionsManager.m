//
//  ActionsManager.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ActionsManager.h"
#import <UMShare/UMShare.h>

@implementation ActionsManager

+ (void)showActionSheetTitle:(nullable NSString *)title
                     message:(nullable NSString *)message
                     configure:(nullable ActionConfigure)configure
                     actions:(NSArray<NSDictionary *> *)actions
                     handler:(ActionHandler)handler {
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:title message:message preferredStyle:QMUIAlertControllerStyleActionSheet];
    if (actions) {
        for (NSDictionary *dic in actions) {
            NSString *actionItemTitle = [dic jk_stringForKey:@"title"];
            QMUIAlertAction *addAction = [QMUIAlertAction actionWithTitle:actionItemTitle style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
                if (handler) {
                    handler(aAlertController, action);
                }
            }];
            if ([dic jk_hasKey:@"key"]) {
                [addAction qmui_bindObject:[dic jk_stringForKey:@"key"] forKey:@"key"];
            } else {
                [addAction qmui_bindObject:[dic jk_stringForKey:@"title"] forKey:@"key"];
            }
            [alertController addAction:addAction];
        }
    }
    [alertController addAction:[QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        if (handler) {
            handler(aAlertController, action);
        }
    }]];
    if (configure) {
        configure(alertController);
    }
    [alertController showWithAnimated:YES];
}

@end
