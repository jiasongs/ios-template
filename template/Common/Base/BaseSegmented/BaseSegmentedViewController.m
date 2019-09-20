//
//  SegmentedViewController.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/8.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseSegmentedViewController.h"

@interface BaseSegmentedViewController ()

@end

@implementation BaseSegmentedViewController

-(void)dealloc {
    
}

-(void)initSubviews {
    [super initSubviews];
}

-(void)initDataSource {
    [super initDataSource];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutSegmentedSubviews];
}

-(void)layoutSegmentedSubviews {
    // 子类重写
}

-(id)listInstanceWithIndex:(NSInteger)index {
    // 子类重写
    return [UIView new];
}

-(void)reloadDataSource {
    if (_segmentedBarView && _segmentedBarView.superview) {
        self.segmentedBarView.titles = self.titleSource;
        [self.segmentedBarView reloadData];
    }
    [self.segmentedContentView reloadData];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(SegmentedBarView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
   
}

- (void)categoryView:(SegmentedBarView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    
}

- (void)categoryView:(SegmentedBarView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.segmentedContentView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(SegmentedBarView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.segmentedContentView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}


#pragma mark - JXCategoryListContainerViewDelegate

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titleSource.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [self listInstanceWithIndex:index];
}

-(NSMutableArray<NSString *> *)titleSource {
    if (!_titleSource) {
        _titleSource = [NSMutableArray array];
    }
    return _titleSource;
}

-(SegmentedBarView *)segmentedBarView {
    if (!_segmentedBarView) {
        _segmentedBarView = [[SegmentedBarView alloc] init];
        _segmentedBarView.delegate = self;
    }
    return _segmentedBarView;
}

-(SegmentedContentView *)segmentedContentView {
    if (!_segmentedContentView ) {
        _segmentedContentView = [[SegmentedContentView alloc] initWithType:0 delegate:self];
    }
    return _segmentedContentView;
}


@end
