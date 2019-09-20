//
//  ExampleSegmentedViewController.m
//  template
//
//  Created by jiasong on 2019/5/16.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ExampleSegmentedViewController.h"
#import "BaseListViewController.h"
#import "BaseTableViewCell.h"
#import "JSScrollView.h"

CGFloat const headerHeight = 200;
NSString *const ExampleSegmentedListCell = @"ExampleSegmentedListCell";

@interface ExampleSegmentedList : BaseListViewController<JXCategoryListContentViewDelegate>

@property(nonatomic, copy) void (^scrollBlock)(UIScrollView *scrollView);

@end

@implementation ExampleSegmentedList

-(void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.tableView];
    [self.tableView setQmui_height:SCREEN_HEIGHT - 50 - NavigationContentTop];
    [self.tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:ExampleSegmentedListCell];
}

-(void)initDataSource {
    [super initDataSource];
    for (int i = 0; i < 20; i++) {
        [self.dataSource addObject:@(i)];
    }
    [self reloadDataSource];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:ExampleSegmentedListCell cacheByIndexPath:indexPath configuration:^(BaseTableViewCell *cell) {
         cell.textLabel.text = NSStringFormat(@"%@",[self.dataSource jk_stringWithIndex:indexPath.row]);
    }];
}

- (nonnull BaseTableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExampleSegmentedListCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initForTableView:tableView withReuseIdentifier:ExampleSegmentedListCell];
    }
    cell.textLabel.text = NSStringFormat(@"%@",[self.dataSource jk_stringWithIndex:indexPath.row]);
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollBlock) {
        self.scrollBlock(scrollView);
    }
}

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

@end


@interface ExampleSegmentedViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) JSScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *currentScrollingListView;

@end

@implementation ExampleSegmentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.titleView.title = @"测试";
}

-(void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.scrollView];
    [self.scrollView addContentSubview:self.headerView];
    [self.scrollView addContentSubview:self.segmentedBarView];
    [self.scrollView addContentSubview:self.segmentedContentView];
    self.segmentedBarView.contentScrollView = self.segmentedContentView.scrollView;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView.contentView);
        make.top.equalTo(self.scrollView.contentView).offset(NavigationContentTop);
        make.height.equalTo(@(headerHeight));
    }];
    [self.segmentedBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.width.equalTo(self.scrollView.contentView);
        make.height.equalTo(@(50));
    }];
    [self.segmentedContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedBarView.mas_bottom).offset(0);
        make.width.equalTo(self.scrollView.contentView);
        make.height.equalTo(@(SCREEN_HEIGHT - 50 - NavigationContentTop));
        make.bottom.equalTo(self.scrollView.contentView);
    }];
}

-(void)initDataSource {
    [super initDataSource];
    self.titleSource = @[@"巴黎23号", @"你", @"蒙面", @"朋友关系"].mutableCopy;
    [self reloadDataSource];
}


-(id)listInstanceWithIndex:(NSInteger)index {
    ExampleSegmentedList *vc =  [ExampleSegmentedList new];
    vc.scrollBlock = ^(UIScrollView *scrollView) {
        [self scrollViewDidScroll:scrollView];
        self.currentScrollingListView = scrollView;
    };
    return vc;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isMemberOfClass:[JSScrollView class]]) {
        if (self.currentScrollingListView != nil && self.currentScrollingListView.contentOffset.y > 0) {
            self.scrollView.contentOffset = CGPointMake(0, headerHeight);
        }
        if (scrollView.contentOffset.y < headerHeight) {
            for (id<JXCategoryListContentViewDelegate> list in self.segmentedContentView.validListDict.allValues) {
                ExampleSegmentedList *segmentedList = (ExampleSegmentedList *)list;
                [segmentedList listScrollView].contentOffset = CGPointZero;
            }
        }
        if (scrollView.contentOffset.y > headerHeight && self.currentScrollingListView.contentOffset.y == 0) {
            self.scrollView.contentOffset = CGPointMake(0, headerHeight);
        }
    } else if ([scrollView isMemberOfClass:[QMUITableView class]]) {
        if (self.scrollView.contentOffset.y < headerHeight) {
            scrollView.contentOffset = CGPointZero;
            scrollView.showsVerticalScrollIndicator = NO;
        } else {
            self.scrollView.contentOffset = CGPointMake(0, headerHeight);
            scrollView.showsVerticalScrollIndicator = YES;
        }
    }
}


-(JSScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[JSScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = UIColorGreen;
    }
    return _headerView;
}

@end
