//
//  MainTabViewController.m
//  template
//
//  Created by jiasong on 2019/4/17.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "MainTabViewController.h"
#import "BaseNavigationController.h"
#import "ExampleHomeViewController.h"
#import "ExampleAboutViewController.h"
#import "PlusTabBarButton.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

-(void)dealloc {
    [self stopReachability];
}

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.getChildViewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetMake(0, -3.5)];

    return (self = (MainTabViewController *)tabBarController);
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    [self startReachability];
}

-(void)initSubViews {
//    [PlusTabBarButton registerPlusButton];
}

-(void)startReachability {
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger startMonitoring];
}

- (void)stopReachability {
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger stopMonitoring];
}


-(NSArray *)getChildViewControllers {
    ExampleHomeViewController *homeVC = [[ExampleHomeViewController alloc] init];
    homeVC.hidesBottomBarWhenPushed = NO;
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
   
    ExampleAboutViewController *aboutVC = [[ExampleAboutViewController alloc] init];
    aboutVC.hidesBottomBarWhenPushed = NO;
    BaseNavigationController *aboutNav = [[BaseNavigationController alloc] initWithRootViewController:aboutVC];
    return @[homeNav, aboutNav];
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"例子",
                            CYLTabBarItemImage : @"tabbar_wrtite_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_wrtite_selected",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"关于",
                            CYLTabBarItemImage : @"tabbar_bulletin_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_bulletin_selected",
                            };
    return  @[dict1, dict2];
}

@end
