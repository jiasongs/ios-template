//
//  BaseViewController.h
//  template
//
//  Created by jiasong on 2019/4/15.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyView.h"
#import "NetworkErrorView.h"

// 通用返回block
typedef void (^CommonCallBackBlock)(id);

@interface BaseViewController : QMUICommonViewController<QMUINavigationControllerAppearanceDelegate>

@property(nonatomic, copy) CommonCallBackBlock commonCallBackBlock;

@property (nonatomic, strong) EmptyView *emptyView;

@property (nonatomic, strong) NetworkErrorView *networkErrorView;

/**
 *  负责初始化和设置controller里面的数据，目的在于分类代码，所以与数据初始化的相关代码都写在这里。
 *
 *  @warning initDataSource只负责数据，不负责布局和初始化。
 */
-(void)initDataSource NS_REQUIRES_SUPER;

-(void)makeViewConstraints NS_REQUIRES_SUPER;


@end


