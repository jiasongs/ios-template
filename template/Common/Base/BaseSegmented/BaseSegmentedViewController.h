//
//  SegmentedViewController.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/8.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseViewController.h"
#import "SegmentedBarView.h"
#import "SegmentedContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseSegmentedViewController : BaseViewController<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSString *> *titleSource;
@property (nonatomic, strong) SegmentedBarView *segmentedBarView;
@property (nonatomic, strong) SegmentedContentView *segmentedContentView;

-(void)reloadDataSource;

// 子类重写来布局segmentedBarView和segmentedContentView
-(void)layoutSegmentedSubviews;
// 子类必须重写
-(id)listInstanceWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
