//
//  AlertManager.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ _Nullable AlertConfigure)(QMUIAlertController * _Nullable alertVC);
typedef void (^ _Nullable AlertHandler)(QMUIAlertController  * _Nullable alertVC, QMUIAlertAction * _Nullable action);

@interface AlertManager : NSObject

/**
 完全自定义
 */
+(void)showCustomView:(nullable UIView *)CustomView;

/**
 显示标题和内容
 */
+(void)showTitle:(nullable NSString *)title
         message:(nullable NSString *)message
       configure:(nullable AlertConfigure)configure;
/**
 显示标题和内容，操作按钮
 */
+(void)showTitle:(nullable NSString *)title
         message:(nullable NSString *)message
     actionTitle:(nullable NSString *)actionTitle
       configure:(nullable AlertConfigure)configure
         handler:(nullable AlertHandler)handler;
/**
 显示标题和内容，操作按钮，取消按钮
 */
+(void)showTitle:(nullable NSString *)title
         message:(nullable NSString *)message
     actionTitle:(nullable NSString *)actionTitle
     cancelTitle:(nullable NSString *)cancelTitle
       configure:(nullable AlertConfigure)configure
         handler:(nullable AlertHandler)handler;

@end


