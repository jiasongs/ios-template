//
//  ExampleHomeViewController.m
//  template
//
//  Created by jiasong on 2019/5/16.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ExampleHomeViewController.h"
#import "ExampleManagerViewController.h"
#import "ExampleSegmentedViewController.h"
#import "ExampleListViewController.h"
#import "ExampleCollectionViewController.h"

@interface ExampleHomeViewController ()


@end

@implementation ExampleHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)lockText {
    //    NSLock *lock = [[NSLock alloc] init];
    dispatch_semaphore_t lock = dispatch_semaphore_create(1);
    NSMutableArray *array = [NSMutableArray array];
    //    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    //    [lock lock];
    Lock(lock);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            [array addObject:@"1"];
            Log(@"%@", array);
            //            [lock unlock];
            //            dispatch_semaphore_signal(lock);
            UnLock(lock);
        });
    });
    //    Lock(lock);
    //    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    Lock(lock);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),dispatch_get_global_queue(0, 0), ^{
            [array addObject:@"2"];
            Log(@"%@", array);
            //            [lock unlock];
            //             dispatch_semaphore_signal(lock);
            UnLock(lock);
        });
    });
}

-(void)serverList {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_t lock = dispatch_semaphore_create(0);
        for (int i = 0; i < 10; i++) {
            ServerRequest *request = [[ServerRequest alloc] init];
            request.url = Api_Topics;
            request.params = @{};
            [ServerInstance getWithRequest:request progress:nil completed:^(ServerResponse *response) {
                Log(@"serverList%d", i);
                UnLock(lock);
            }];
            Lock(lock);
        }
    });
}

-(void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTop);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabBarHeight);
    }];
}

-(void)initDataSource {
    [super initDataSource];
//    [self lockText];
//    [self serverList];
    NSArray *cellDataArray = @[
                               @[({
                                   QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                   d.identifier = 1;
                                   d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                   d.height = TableViewCellNormalHeight;
                                   d.text = @"Manager类";
                                   d.didSelectTarget = self;
                                   d.didSelectAction = @selector(onPressManager);
                                   d;
                                }),
                                 ({
                                     QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                     d.identifier = 2;
                                     d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                     d.height = TableViewCellNormalHeight;
                                     d.text = @"Button";
                                     d;
                                 }),
                                 ({
                                     QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                     d.identifier = 3;
                                     d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                     d.height = TableViewCellNormalHeight ;
                                     d.text = @"查看大图";
                                     d;
                                 }),
                                 ({
                                     QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                     d.identifier = 4;
                                     d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                     d.height = TableViewCellNormalHeight ;
                                     d.text = @"Segmented";
                                     d.didSelectTarget = self;
                                     d.didSelectAction = @selector(onPressSegmented);
                                     d;
                                 }),
                                 ({
                                     QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                     d.identifier = 4;
                                     d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                     d.height = TableViewCellNormalHeight ;
                                     d.text = @"List";
                                     d.didSelectTarget = self;
                                     d.didSelectAction = @selector(onPressList);
                                     d;
                                 }),
                                 ({
                                     QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                     d.identifier = 4;
                                     d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                     d.height = TableViewCellNormalHeight ;
                                     d.text = @"Collection";
                                     d.didSelectTarget = self;
                                     d.didSelectAction = @selector(onPressCollection);
                                     d;
                                 }),
                                 ],
                               
                               ];
    QMUIStaticTableViewCellDataSource *dataSource = [[QMUIStaticTableViewCellDataSource alloc] initWithCellDataSections:cellDataArray];
    // 把数据塞给 tableView 即可
    self.tableView.qmui_staticCellDataSource = dataSource;
}

-(void)setupNavigationItems {
    [super setupNavigationItems];
    self.titleView.title = @"例子";
}

-(void)onPressManager {
    UIView *view = [[UIView alloc] qmui_initWithSize:CGSizeMake(375, 200)];
    view.backgroundColor = [UIColor whiteColor];
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
       modalViewController.contentView = view;
        modalViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
       [modalViewController showWithAnimated:YES completion:nil];
//    ExampleManagerViewController *vc = [ExampleManagerViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressSegmented {
    ExampleSegmentedViewController *vc = [ExampleSegmentedViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressList {
    ExampleListViewController *vc = [ExampleListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressCollection {
    ExampleCollectionViewController *vc = [ExampleCollectionViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
