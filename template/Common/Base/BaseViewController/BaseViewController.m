//
//  BaseViewController.m
//  template
//
//  Created by jiasong on 2019/4/15.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize emptyView = _emptyView;

-(void)dealloc {
    Log(@"dealloc-%@",self);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    // 第一步，执行initSubviews(此方法在父类的viewDidLoad里调用)
    [super viewDidLoad];
    // 第二步，执行makeViewConstraints
    [self makeViewConstraints];
    // 第三步，执行initDataSource
    [self initDataSource];
}

-(void)initSubviews {
    [super initSubviews];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 子类重写
}

-(void)makeViewConstraints {
   // 子类重写
}

-(void)initDataSource {
    // 子类重写
    // 开启网络监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    // 子类重写
}

- (void)setupToolbarItems {
    [super setupToolbarItems];
    // 子类重写
}

- (void)showEmptyView {
    if (!self.emptyView) {
        self.emptyView = [[EmptyView alloc] init];
        [self.view addSubview:self.emptyView];
    }
    [self layoutEmptyView];
}

- (void)hideEmptyView {
    if (self.emptyView) {
        [self.emptyView removeFromSuperview];
        self.emptyView = nil;
    }
}

-(void)showNetworkErrorView {
    if (!self.networkErrorView) {
        self.networkErrorView = [[NetworkErrorView alloc] init];
        [self.view addSubview:self.networkErrorView];
    }
    [self layoutNetworkErrorView];
}

-(void)hideNetworkErrorView {
    if (self.networkErrorView) {
        [self.networkErrorView removeFromSuperview];
        self.networkErrorView = nil;
    }
}

- (BOOL)layoutEmptyView {
    if (self.emptyView) {
        BOOL viewDidLoad = self.emptyView.superview && [self isViewLoaded];
        if (viewDidLoad) {
            CGSize newEmptyViewSize = self.emptyView.superview.bounds.size;
            CGSize oldEmptyViewSize = self.emptyView.frame.size;
            if (!CGSizeEqualToSize(newEmptyViewSize, oldEmptyViewSize)) {
                self.emptyView.qmui_frameApplyTransform = CGRectFlatMake(CGRectGetMinX(self.emptyView.frame), CGRectGetMinY(self.emptyView.frame), newEmptyViewSize.width, newEmptyViewSize.height);
            }
             return NO;
        }
    }
    return YES;
}

-(BOOL)layoutNetworkErrorView {
    if (self.networkErrorView) {
        BOOL viewDidLoad = self.networkErrorView.superview && [self isViewLoaded];
        if (viewDidLoad) {
            CGSize newEmptyViewSize = self.networkErrorView.superview.bounds.size;
            CGSize oldEmptyViewSize = self.networkErrorView.frame.size;
            if (!CGSizeEqualToSize(newEmptyViewSize, oldEmptyViewSize)) {
                self.networkErrorView.qmui_frameApplyTransform = CGRectFlatMake(CGRectGetMinX(self.networkErrorView.frame), CGRectGetMinY(self.networkErrorView.frame), newEmptyViewSize.width, newEmptyViewSize.height);
            }
            return NO;
        }
    }
     return YES;
}


-(BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (void)reachabilityDidChange:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    dispatch_async(dispatch_get_main_queue(), ^{
        switch ([info jk_integerForKey:AFNetworkingReachabilityNotificationStatusItem]) {
            case AFNetworkReachabilityStatusUnknown:
                [self showNetworkErrorView];
                Log(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [self showNetworkErrorView];
                Log(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self hideNetworkErrorView];
                Log(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self hideNetworkErrorView];
                Log(@"WiFi");
                break;
            default:
                break;
        }
    });
}

@end
