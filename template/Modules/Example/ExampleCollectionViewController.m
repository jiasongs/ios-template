//
//  ExampleCollectionViewController.m
//  template
//
//  Created by jiasong on 2019/5/30.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ExampleCollectionViewController.h"
#import "BaseCollectionViewCell.h"

NSString *const ExampleCollectionCellIdentifier = @"ExampleCollectionCellIdentifier";

@interface ExampleCollectionViewController ()

@end

@implementation ExampleCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)initSubviews {
    [super initSubviews];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (SCREEN_WIDTH - 20) / 2;
    CGFloat itemH = itemW * 256 / 180;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    self.collectionView = [self createCollectionViewWithLayout:layout];
    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:ExampleCollectionCellIdentifier];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationContentTop);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.enableRefresh = YES;
    self.enableLoadMore = YES;
}

-(void)initDataSource {
    [super initDataSource];
    self.limit = 20;
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.titleView.title = @"列表";
}

-(void)onRequestDataSource {
    ServerRequest *request = [[ServerRequest alloc] init];
    request.url = Api_Topics;
    request.params = @{
                       @"tab":@"good",
                       @"limit":@(self.limit),
                       @"page":@(self.page)
                       };
    [ServerInstance getWithRequest:request progress:nil completed:^(ServerResponse *response) {
        BOOL noMoreData = NO;
        if (response.successful) {
            NSArray *array = [response.originalData jk_arrayForKey:@"data"];
            if (self.page == 1) {
                self.dataSource = array.mutableCopy;
            } else if (self.page > 1) {
                if (array.count < self.limit) {
                    noMoreData = YES;
                }
                [self.dataSource addObjectsFromArray:array];
            }
        } else {
            if (self.page > 1) {
                self.page--;
            }
            [ToastManager showError:response.message];
        }
        [self stopRefreshWithNoMoreData:noMoreData];
        [self reloadDataSource];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ExampleCollectionCellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColorBlue;
    return cell;
}

@end
