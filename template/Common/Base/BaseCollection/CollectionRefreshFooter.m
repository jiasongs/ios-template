//
//  ListRefreshFooter.m
//  template
//
//  Created by jiasong on 2019/5/14.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "CollectionRefreshFooter.h"

@interface CollectionRefreshFooter ()

@end

@implementation CollectionRefreshFooter

// 重写父类
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
    // 设置位置
    if (self.scrollView.mj_contentH < self.scrollView.mj_h) {
        self.mj_y = self.scrollView.mj_h;
    } else {
        self.mj_y = self.scrollView.mj_contentH;
    }
}

@end
