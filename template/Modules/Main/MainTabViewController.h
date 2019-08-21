//
//  MainTabViewController.h
//  template
//
//  Created by jiasong on 2019/4/17.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseViewController.h"

#if __has_include(<CYLTabBarController/CYLTabBarController.h>)
#import <CYLTabBarController/CYLTabBarController.h>
#else
#import "CYLTabBarController.h"
#endif

@interface MainTabViewController : CYLTabBarController

@end


