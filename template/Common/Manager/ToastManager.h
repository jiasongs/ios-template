//
//  ToastManager.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToastManager : NSObject

+ (QMUITips *)showMessage:(NSString *)message;
+ (QMUITips *)showMessage:(NSString *)message detail:(nullable NSString *)detail;

+ (QMUITips *)showLoading:(NSString *)message;
+ (QMUITips *)showLoading:(NSString *)message detail:(nullable NSString *)detail;

+ (QMUITips *)showSucceed:(NSString *)message;
+ (QMUITips *)showSucceed:(NSString *)message detail:(nullable NSString *)detail;

+ (QMUITips *)showError:(NSString *)error;
+ (QMUITips *)showError:(NSString *)error detail:(nullable NSString *)detail;
+ (QMUITips *)showInfo:(NSString *)message;
+ (QMUITips *)showInfo:(NSString *)message detail:(nullable NSString *)detail;

+ (void)hideAllToast;

@end

NS_ASSUME_NONNULL_END
