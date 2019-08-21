//
//  SegmentedBarView.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "SegmentedBarView.h"

@interface SegmentedBarView ()

@end

@implementation SegmentedBarView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)dealloc {
    Log(@"dealloc");
}

-(void)initializeData {
    [super initializeData];
}

-(void)initializeViews {
    [super initializeViews];
    self.titleColorGradientEnabled = YES;
    self.indicators = @[self.lineView];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryTitleImageCellModel *cellModel = [[JXCategoryTitleImageCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    if (self.imageTypes == nil || self.imageTypes.count == 0) {
        NSMutableArray *types = [NSMutableArray array];
        for (int i = 0; i < self.titles.count; i++) {
            [types addObject:@(JXCategoryTitleImageType_OnlyTitle)];
        }
        self.imageTypes = types;
    }
    self.dataSource = tempArray;
}

-(JXCategoryIndicatorLineView *)lineView {
    if (!_lineView) {
        _lineView = [[JXCategoryIndicatorLineView alloc] init];
    }
    return _lineView;
}

@end
