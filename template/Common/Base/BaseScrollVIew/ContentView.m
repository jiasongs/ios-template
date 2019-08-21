//
//  ContentView.m
//  MagicMiss
//
//  Created by jiasong on 2019/4/24.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ContentView.h"

@interface ContentView ()

@end

@implementation ContentView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self didInitialize];
    }
    return self;
}

-(void)didInitialize {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    UIView *lastView = self.subviews.lastObject;
//    CGFloat sizeHeight = self.layoutMargins.bottom + lastView.qmui_bottom;
//    Log(@"layoutMargins-%@",NSStringFromUIEdgeInsets(self.layoutMargins));
//    if (sizeHeight != self.qmui_height) {
//        Log(@"%f",lastView.qmui_bottom);
//        UIScrollView *scrollView = (UIScrollView *)self.superview;
//        CGFloat originY = scrollView.contentInset.top;
//        CGFloat originX = scrollView.contentInset.left;
//        CGFloat sizeWidth = self.superview.qmui_width - (scrollView.contentInset.right + scrollView.contentInset.left);
//        self.frame = CGRectMake(originY, originX, sizeWidth, sizeHeight);
//    }
}


@end
