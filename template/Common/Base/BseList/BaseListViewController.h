//
//  TableListViewController.h
//  template
//
//  Created by jiasong on 2019/4/15.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseListViewController : BaseViewController<QMUITableViewDelegate, QMUITableViewDataSource>

@property (nonatomic, strong) QMUITableView *tableView;

@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign, getter=isEnableRefresh) BOOL enableRefresh;
@property (nonatomic, assign, getter=isEnableLoadMore) BOOL enableLoadMore;

@property (nonatomic, strong) NSMutableArray *dataSource;

// 网络请求
-(void)onRequestDataSource;
// 刷新数据
-(void)reloadDataSource;
-(void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
-(void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
// 停止 上拉/下拉刷新
-(void)stopRefreshWithNoMoreData:(BOOL)noMoreData;


@end


