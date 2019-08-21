//
//  JSScrollView.h
//  MagicMiss
//
//  Created by jiasong on 2019/4/24.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSScrollView : UIScrollView

@property (nonatomic, strong) ContentView *contentView;

-(void)addContentSubview:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
