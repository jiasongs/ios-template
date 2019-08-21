//
//  ActionsManager.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ActionConfigure)(QMUIAlertController * _Nullable alertVC);
typedef void (^ActionHandler)(QMUIAlertController * _Nonnull alertVC, QMUIAlertAction * _Nonnull action);

@interface ActionsManager : NSObject

+ (void)showActionSheetTitle:(nullable NSString *)title
                     message:(nullable NSString *)message
                   configure:(nullable ActionConfigure)configure
                     actions:(nullable NSArray<NSDictionary *> *)actions
                     handler:(nullable ActionHandler)handler;

@end


