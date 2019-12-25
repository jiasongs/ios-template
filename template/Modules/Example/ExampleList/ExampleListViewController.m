//
//  ExampleListViewController.m
//  template
//
//  Created by jiasong on 2019/5/23.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ExampleListViewController.h"
#import "ExampleListTableViewCell.h"
#import "ExampleListModel.h"

NSString *const ExampleListCellIdentifier = @"ExampleListCellIdentifier";

@interface ExampleListViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ExampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ExampleListTableViewCell class] forCellReuseIdentifier:ExampleListCellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTop);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.enableRefresh = true;
    self.enableLoadMore = true;
}

-(void)initDataSource {
    [super initDataSource];
    self.limit = 20;
//    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.titleView.title = @"列表";
}

- (void)timerSelector {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.dataSource jk_each:^(ExampleListModel *model) {
            model.count = model.count + 1;
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

-(void)onRequestDataSource {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
    self.dataSource = [ExampleListModel arrayOfModelsFromDictionaries:array error:nil];
    [self stopRefreshWithNoMoreData:NO];
    [self reloadDataSource];
//    ServerRequest *request = [[ServerRequest alloc] init];
//    request.url = Api_Topics;
//    request.params = @{
//                       @"tab":@"good",
//                       @"limit":@(self.limit),
//                       @"page":@(self.page)
//                       };
//    [ServerInstance getWithRequest:request progress:nil completed:^(ServerResponse *response) {
//        BOOL noMoreData = NO;
//        if (response.successful) {
//            [[NSUserDefaults standardUserDefaults] setValue:[response.originalData jk_arrayForKey:@"data"] forKey:@"data"];
//            NSMutableArray *array =  [ExampleListModel arrayOfModelsFromDictionaries:[response.originalData jk_arrayForKey:@"data"] error:nil];
//            if (self.page == 1) {
//                self.dataSource = array;
//            } else if (self.page > 1) {
//                if (array.count < self.limit) {
//                    noMoreData = YES;
//                }
//                [self.dataSource addObjectsFromArray:array];
//            }
//            for (int i = 0; i < self.dataSource.count; i++) {
//                ExampleListModel *model = self.dataSource[i];
//                if (i < 3) {
//                    if (i == 0) {
//                        model.imageArray = @[];
//                    } else {
//                        model.imageArray = @[@"1",@"2",@"3"];
//                    }
//                } else if (i < 7) {
//                    model.imageArray = @[@"1",@"2",@"3",@"4",@"5"];
//                } else {
//                    model.imageArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
//                }
//            }
//        } else {
//            if (self.page > 1) {
//                self.page--;
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [ToastManager showError:response.message];
//            });
//        }
//        [self stopRefreshWithNoMoreData:noMoreData];
//        [self reloadDataSource];
//    }];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    Log(@"willDisplayCell%@", cell);
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    Log(@"didEndDisplayingCell%@", cell);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:ExampleListCellIdentifier cacheByIndexPath:indexPath configuration:^(BaseTableViewCell *cell) {
        ExampleListModel *model = [self.dataSource jk_objectWithIndex:indexPath.row];
        [cell updateCellWithModel:model indexPath:indexPath];
    }];
}

- (ExampleListTableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ExampleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExampleListCellIdentifier forIndexPath:indexPath];
    ExampleListModel *model = [self.dataSource jk_objectWithIndex:indexPath.row];
    [cell updateCellWithModel:model indexPath:indexPath];
    return cell;
}

@end
