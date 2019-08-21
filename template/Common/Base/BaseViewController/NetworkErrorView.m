//
//  NetwotkErrorView.m
//  template
//
//  Created by jiasong on 2019/6/19.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "NetworkErrorView.h"

@implementation NetworkErrorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = QMUICMI.backgroundColor;
        [self setImage:UIImageMake(@"img_empty")];
        [self setTextLabelText:@"网络错误"];
        [self setActionButtonTitle:@"重试"];
        self.loadingView.hidden = YES;
    }
    return self;
}


@end
