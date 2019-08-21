//
//  BaseCollectionViewController.m
//  template
//
//  Created by jiasong on 2019/5/30.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import <MJRefresh.h>
#import "CollectionRefreshHeader.h"
#import "CollectionRefreshFooter.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

-(void)dealloc {
    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;
}

-(void)initSubviews {
    [super initSubviews];
   
}

-(void)initDataSource {
    [super initDataSource];
    self.limit = 10;
    self.page = 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.collectionView.allowsMultipleSelection) {
        [self.collectionView qmui_clearsSelection];
    }
}


- (void)setEnableRefresh:(BOOL)enableRefresh {
    _enableRefresh = enableRefresh;
    if (enableRefresh && !self.collectionView.mj_header) {
        self.collectionView.mj_header = [CollectionRefreshHeader headerWithRefreshingBlock:self.headerRefreshingBlock];
        [self.collectionView.mj_header beginRefreshing];
    } else if (!enableRefresh && self.collectionView.mj_header) {
        [self.collectionView.mj_header removeFromSuperview];
        self.collectionView.mj_header = nil;
    }
}

-(void)setEnableLoadMore:(BOOL)enableLoadMore {
    _enableLoadMore = enableLoadMore;
    if (enableLoadMore && !self.collectionView.mj_footer) {
        self.collectionView.mj_footer = [CollectionRefreshFooter footerWithRefreshingBlock:self.footerRefreshingBlock];
    } else if (!enableLoadMore && self.collectionView.mj_footer) {
        [self.collectionView.mj_footer removeFromSuperview];
        self.collectionView.mj_footer = nil;
    }
}

-(void(^)(void))headerRefreshingBlock {
    @weakify(self);
    return ^(void) {
        @strongify(self);
        self.page = 1;
        [self onRequestDataSource];
    };
}

-(void(^)(void))footerRefreshingBlock {
    @weakify(self);
    return ^(void) {
        @strongify(self);
        self.page++;
        [self onRequestDataSource];
    };
}


-(void)onRequestDataSource {
    
}

-(void)reloadDataSource {
    DispatchAsyncOnMainQueue({
        if (self.dataSource.count == 0) {
            [self showEmptyView];
        } else {
            [self hideEmptyView];
        }
        [self.collectionView reloadData];
    });
}

-(void)stopRefreshWithNoMoreData:(BOOL)noMoreData {
    DispatchAsyncOnMainQueue({
        if (self.collectionView.mj_header && self.collectionView.mj_header.isRefreshing) {
            if (self.collectionView.mj_footer) {
                [self.collectionView.mj_footer resetNoMoreData];
            }
            [self.collectionView.mj_header endRefreshing];
        }
        if (self.collectionView.mj_footer && self.collectionView.mj_footer.isRefreshing) {
            if (noMoreData) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.collectionView.mj_footer endRefreshing];
            }
        }
    });
}

- (void)showEmptyView {
    if (!self.emptyView) {
        self.emptyView = [[EmptyView alloc] init];
        [self.collectionView addSubview:self.emptyView];
    }
    [self layoutEmptyView];
}

- (BOOL)layoutEmptyView {
    if (!self.emptyView) {
        return NO;
    }
    UIEdgeInsets insets = self.collectionView.contentInset;
    if (@available(iOS 11, *)) {
        if (self.collectionView.contentInsetAdjustmentBehavior != UIScrollViewContentInsetAdjustmentNever) {
            insets = self.collectionView.adjustedContentInset;
        }
    }
    self.emptyView.frame = CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds) - UIEdgeInsetsGetHorizontalValue(insets), CGRectGetHeight(self.collectionView.bounds) - UIEdgeInsetsGetVerticalValue(insets));
    return YES;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [UICollectionViewCell new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
   
}


-(UICollectionView *)createCollectionViewWithLayout:(UICollectionViewLayout *)collectionViewLayout {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:collectionViewLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _collectionView.backgroundColor = UIColorWhite;
    }
    return _collectionView;
}


-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
