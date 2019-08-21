//
//  ExampleManagerViewController.m
//  template
//
//  Created by jiasong on 2019/5/17.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ExampleManagerViewController.h"
#import "MediaPickerManager.h"

@interface ExampleManagerViewController ()

@property (nonatomic, assign) NSUInteger toastMark;

@end

@implementation ExampleManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTop);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

-(void)initDataSource {
    [super initDataSource];
    NSArray *cellDataArray = @[
                               @[({
                                   QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                   d.identifier = 1;
                                   d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                   d.height = TableViewCellNormalHeight;
                                   d.text = @"Alert";
                                   d.didSelectTarget = self;
                                   d.didSelectAction = @selector(onPressAlert);
                                   d;
                               }),
                                 ({
                                     QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                     d.identifier = 2;
                                     d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                     d.height = TableViewCellNormalHeight;
                                     d.text = @"Toast";
                                     d.didSelectTarget = self;
                                     d.didSelectAction = @selector(onPressToast);
                                     d;
                                 }),
                                 ({
                                     QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                     d.identifier = 4;
                                     d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                     d.height = TableViewCellNormalHeight ;
                                     d.text = @"Action";
                                     d.didSelectTarget = self;
                                     d.didSelectAction = @selector(onPressAction);
                                     d;
                                 }),
                                 ({
                                     QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                                     d.identifier = 3;
                                     d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                                     d.height = TableViewCellNormalHeight ;
                                     d.text = @"MediaPicker";
                                     d.didSelectTarget = self;
                                     d.didSelectAction = @selector(onPressMediaPicker);
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
    self.titleView.title = @"Manager";
}

- (void)onPressAlert {
    [AlertManager showTitle:@"标题" message:@"您点击了弹窗，是否确认" actionTitle:@"确认" cancelTitle:@"NO" configure:^(QMUIAlertController *alertVC) {
//        [alertVC addTextFieldWithConfigurationHandler:^(QMUITextField * _Nonnull textField) {
//            
//        }];
    } handler:^(QMUIAlertController *alertVC, QMUIAlertAction *action) {
        if (action.style == QMUIAlertActionStyleCancel) {
            [ToastManager showMessage: @"点击了取消按钮" detail:nil];
        } else {
            [ToastManager showSucceed:@"已确认" detail:nil];
        }
    }];
}

- (void)onPressToast {
    if (_toastMark == 0) {
        [ToastManager showMessage:@"我是showMessage" detail:nil];
    } else if (_toastMark == 1) {
        [ToastManager showSucceed:@"我是showSucceed" detail:nil];
    } else if (_toastMark == 2) {
        [ToastManager showInfo:@"我是showInfo" detail:nil];
    } else if (_toastMark == 3) {
        [ToastManager showError:@"我是showError" detail:nil];
    } else if (_toastMark == 4) {
        QMUITips *tips = [ToastManager showLoading:@"我是showLoading" detail:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tips hideAnimated:YES];
        });
    }
    if (_toastMark == 4) {
         _toastMark = 0;
    } else {
        _toastMark++;
    }
}

- (void)onPressAction {
    NSArray *array = @[
                       @{@"title":@"title1",@"key":@"1"},
                        @{@"title":@"title2",@"key":@"2"},
                       ];
    [ActionsManager showActionSheetTitle:@"标题" message:nil configure:nil actions:array handler:^(QMUIAlertController *alertVC, QMUIAlertAction *action) {
        NSString *key = [action qmui_getBoundObjectForKey:@"key"];
        if ([key isEqualToString:@"1"]) {
            [ToastManager showMessage:@"title1" detail:nil];
        } else if ([key isEqualToString:@"2"]) {
            [ToastManager showMessage:@"title2" detail:nil];
        }
    }];
}

- (void)onPressMediaPicker {
    [MediaPickerManager showChoosePickerWithType:MediaTypeImage configure:nil completed:^(NSArray<NSDictionary *> *infos) {
        
    }];
}






@end
