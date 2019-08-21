//
//  SegmentedBarView.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "JXCategoryTitleImageView.h"
#import "JXCategoryIndicatorLineView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SegmentedBarView : JXCategoryTitleImageView

@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;

@end

NS_ASSUME_NONNULL_END
