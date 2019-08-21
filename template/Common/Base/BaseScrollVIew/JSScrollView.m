//
//  JSScrollView.m
//  MagicMiss
//
//  Created by jiasong on 2019/4/24.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "JSScrollView.h"

@interface JSScrollView ()<UIGestureRecognizerDelegate>


@end

@implementation JSScrollView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self didInitialize];
    }
    return self;
}

-(void)didInitialize {
    self.alwaysBounceVertical = YES;
    self.contentInset = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
        make.height.greaterThanOrEqualTo(@0.f);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self updateContentSizeIfNeeded];
}

- (void)updateContentSizeIfNeeded {
    CGSize contentSize = self.contentView.jk_size;
    if (!CGSizeEqualToSize(self.contentSize, contentSize)) {
        Log(@"updateContentOffsetIfNeeded");
        self.contentSize = contentSize;
    }
}

-(void)addContentSubview:(UIView *)view {
    if (view) {
        [self.contentView addSubview:view];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (ContentView *)contentView {
    if (!_contentView) {
        _contentView = [[ContentView alloc] init];
    }
    return _contentView;
}

@end
