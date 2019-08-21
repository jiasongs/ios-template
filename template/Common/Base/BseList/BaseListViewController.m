//
//  TableListViewController.m
//  template
//
//  Created by jiasong on 2019/4/15.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseListViewController.h"
#import <MJRefresh.h>
#import "ListRefreshHeader.h"
#import "ListRefreshFooter.h"

@interface BaseListViewController ()

@end

@implementation BaseListViewController

-(void)dealloc {
   
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
    if (!self.tableView.allowsMultipleSelection) {
        [self.tableView qmui_clearsSelection];
    }
}

-(void)onRequestDataSource {
    
}

- (void)setEnableRefresh:(BOOL)enableRefresh {
    _enableRefresh = enableRefresh;
    if (enableRefresh && !self.tableView.mj_header) {
        self.tableView.mj_header = [ListRefreshHeader headerWithRefreshingBlock:self.headerRefreshingBlock];
        [self.tableView.mj_header beginRefreshing];
    } else if (!enableRefresh && self.tableView.mj_header) {
        [self.tableView.mj_header removeFromSuperview];
        self.tableView.mj_header = nil;
    }
}

-(void)setEnableLoadMore:(BOOL)enableLoadMore {
    _enableLoadMore = enableLoadMore;
    if (enableLoadMore && !self.tableView.mj_footer) {
        self.tableView.mj_footer = [ListRefreshFooter footerWithRefreshingBlock:self.footerRefreshingBlock];
    } else if (!enableLoadMore && self.tableView.mj_footer) {
        [self.tableView.mj_footer removeFromSuperview];
        self.tableView.mj_footer = nil;
    }
}

-(void(^)(void))headerRefreshingBlock {
    @weakify(self);
    return ^(void) {
        @strongify(self);
        if (self.tableView.mj_footer && self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        } else {
            self.page = 1;
            [self onRequestDataSource];
        }
    };
}

-(void(^)(void))footerRefreshingBlock {
    @weakify(self);
    return ^(void) {
        @strongify(self);
        if (self.tableView.mj_header && self.tableView.mj_header.isRefreshing) {
           [self.tableView.mj_footer endRefreshing];
        } else {
            self.page++;
            [self onRequestDataSource];
        }
    };
}

-(void)reloadDataSource {
    DispatchAsyncOnMainQueue({
        if (self.dataSource.count == 0) {
            [self showEmptyView];
        } else {
            [self hideEmptyView];
        }
        [self.tableView reloadData];
    });
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    DispatchAsyncOnMainQueue({
        if (self.dataSource.count == 0) {
            [self showEmptyView];
        } else {
            [self hideEmptyView];
        }
        [self.tableView reloadSections:sections withRowAnimation:animation];
    });
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    DispatchAsyncOnMainQueue({
        if (self.dataSource.count == 0) {
            [self showEmptyView];
        } else {
            [self hideEmptyView];
        }
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    });
}

-(void)stopRefreshWithNoMoreData:(BOOL)noMoreData {
    DispatchAsyncOnMainQueue({
        if (self.tableView.mj_header && self.tableView.mj_header.isRefreshing) {
            if (self.tableView.mj_footer) {
                [self.tableView.mj_footer resetNoMoreData];
            }
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer && self.tableView.mj_footer.isRefreshing) {
            if (noMoreData) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    });
}

- (void)showEmptyView {
    if (!self.emptyView) {
        self.emptyView = [[EmptyView alloc] init];
        [self.tableView addSubview:self.emptyView];
    }
    [self layoutEmptyView];
}

- (BOOL)layoutEmptyView {
    if (!self.emptyView) {
        return NO;
    }
    UIEdgeInsets insets = self.tableView.contentInset;
    if (@available(iOS 11, *)) {
        if (self.tableView.contentInsetAdjustmentBehavior != UIScrollViewContentInsetAdjustmentNever) {
            insets = self.tableView.adjustedContentInset;
        }
    }
    // 当存在 tableHeaderView 时，emptyView 的高度为 tableView 的高度减去 headerView 的高度
    if (self.tableView.tableHeaderView) {
        self.emptyView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.tableHeaderView.frame), CGRectGetWidth(self.tableView.bounds) - UIEdgeInsetsGetHorizontalValue(insets), CGRectGetHeight(self.tableView.bounds) - UIEdgeInsetsGetVerticalValue(insets) - CGRectGetMaxY(self.tableView.tableHeaderView.frame));
    } else {
        self.emptyView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds) - UIEdgeInsetsGetHorizontalValue(insets), CGRectGetHeight(self.tableView.bounds) - UIEdgeInsetsGetVerticalValue(insets));
    }
    return NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, self.view.jk_height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



@end
