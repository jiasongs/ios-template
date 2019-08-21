//
//  ToastManager.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ToastManager.h"

@implementation ToastManager

+(QMUITips *)showMessage:(NSString *)message {
    return [QMUITips showWithText:message detailText:nil];
}

+ (QMUITips *)showMessage:(NSString *)message detail:(nullable NSString *)detail {
   return [QMUITips showWithText:message detailText:detail];
}

+ (QMUITips *)showSucceed:(NSString *)message {
    QMUITips *tips = [QMUITips showSucceed:message detailText:nil];
    [self resetToastContentView:tips];
    return tips;
}

+ (QMUITips *)showSucceed:(NSString *)message detail:(nullable NSString *)detail {
    QMUITips *tips = [QMUITips showSucceed:message detailText:detail];
    [self resetToastContentView:tips];
    return tips;
}

+ (QMUITips *)showError:(NSString *)error {
    QMUITips *tips = [QMUITips showError:error detailText:nil];
    [self resetToastContentView:tips];
    return tips;
}

+ (QMUITips *)showError:(NSString *)error detail:(nullable NSString *)detail {
    QMUITips *tips = [QMUITips showError:error detailText:detail];
    [self resetToastContentView:tips];
    return tips;
}

+ (QMUITips *)showLoading:(NSString *)message {
    QMUITips *tips = [QMUITips showLoading:message detailText:nil inView:DefaultTipsParentView];
    [self resetToastContentView:tips];
    return tips;
}

+ (QMUITips *)showInfo:(NSString *)message {
    QMUITips *tips = [QMUITips showInfo:message detailText:nil];
    [self resetToastContentView:tips];
    return tips;
}

+ (QMUITips *)showLoading:(NSString *)message detail:(nullable NSString *)detail {
    QMUITips *tips = [QMUITips showLoading:message detailText:detail inView:DefaultTipsParentView];
    [self resetToastContentView:tips];
    return tips;
}

+ (QMUITips *)showInfo:(NSString *)message detail:(nullable NSString *)detail {
    QMUITips *tips = [QMUITips showInfo:message detailText:detail];
    [self resetToastContentView:tips];
    return tips;
}

+ (void)hideAllToast {
    [QMUITips hideAllTips];
}

+(void)resetToastContentView:(QMUITips *)tips {
    QMUIToastContentView *contentView = (QMUIToastContentView *)tips.contentView;
    contentView.insets = UIEdgeInsetsMake(15, 20, ScaleSize(11), 20);
    contentView.minimumSize = CGSizeMake(100, 90);
}


@end
