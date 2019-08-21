//
//  AppDelegate+Configure.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "AppDelegate+Configure.h"
#import "MainTabViewController.h"
#import "IQKeyboardManager.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

@implementation AppDelegate (Configure)

- (void)commonConfigure {
    [self configureRootController];
    [self configureIQKeyboardManager];
//    [self configureUMeng];
//    [self configureUShare];
}

- (void)configureRootController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainTabViewController *mainVC = [[MainTabViewController alloc] init];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
}

- (void)configureIQKeyboardManager {
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES;
    keyboardManager.shouldResignOnTouchOutside = YES;
    NSArray *disabledClassArray = @[
                                    [NSClassFromString(@"QMUIAlertController") class],
                                    [NSClassFromString(@"QMUIDialogViewController") class],
                                    [NSClassFromString(@"QMUIModalPresentationViewController") class],
                                    ];
    [keyboardManager.disabledDistanceHandlingClasses addObjectsFromArray:disabledClassArray];

}

-(void)configureUMeng {
    NSDictionary *infoDic = [self getThirdpartyInfo];
    [UMConfigure initWithAppkey:infoDic[@"appKey"] channel:infoDic[@"channel"]];
}

-(void)configureUShare {
    NSDictionary *infoDic = [self getThirdpartyInfo];
    UMSocialManager *manager = [UMSocialManager defaultManager];
    if ([infoDic jk_stringForKey:@"wechatAppId"]) {
        /* 设置微信的appKey和appSecret */
        [manager setPlaform:UMSocialPlatformType_WechatSession appKey:infoDic[@"wechatAppId"] appSecret:infoDic[@"wechatAppSecret"] redirectURL:@"http://mobile.umeng.com/social"];
    }
    if ([infoDic jk_stringForKey:@"qqAppId"]) {
         [manager setPlaform:UMSocialPlatformType_QQ appKey:infoDic[@"qqAppId"] appSecret:infoDic[@"qqAppKey"] redirectURL:@"http://mobile.umeng.com/social"];
    }
    if ([infoDic jk_stringForKey:@"sinaWeiboAppKey"]) {
        
    }
}

-(NSDictionary *)getThirdpartyInfo {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ThirdpartyInfo" ofType:@"plist"];
    NSDictionary *infoDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return infoDic;
}


@end
