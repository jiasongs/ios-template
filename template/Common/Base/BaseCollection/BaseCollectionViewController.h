//
//  BaseCollectionViewController.h
//  template
//
//  Created by jiasong on 2019/5/30.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign, getter=isEnableRefresh) BOOL enableRefresh;
@property (nonatomic, assign, getter=isEnableLoadMore) BOOL enableLoadMore;

@property (nonatomic, strong) NSMutableArray *dataSource;

// 创建collectionView
-(UICollectionView *)createCollectionViewWithLayout:(UICollectionViewLayout *)collectionViewLayout;

// 网络请求
-(void)onRequestDataSource;
// 刷新数据
-(void)reloadDataSource;
// 停止 上拉/下拉刷新
-(void)stopRefreshWithNoMoreData:(BOOL)noMoreData;

@end

NS_ASSUME_NONNULL_END
