//
//  EmptyView.m
//  template
//
//  Created by jiasong on 2019/6/19.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = QMUICMI.backgroundColor;
        [self setImage:UIImageMake(@"icon_no_record")];
        [self setTextLabelText:@"暂无数据"];
        self.loadingView.hidden = YES;
    }
    return self;
}

@end
