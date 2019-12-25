//
//  ExampleListTableViewCell.m
//  template
//
//  Created by jiasong on 2019/6/4.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ExampleListTableViewCell.h"
#import <UIImage+Transform.h>

const CGFloat DefaultPictureCount = 9;
const CGFloat SeparatorWidth = 10;
#define PictureItemWidth ((SCREEN_WIDTH - SeparatorWidth * 4) / 3)

@interface ExampleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) QMUIButton *button;

@end

@implementation ExampleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.button];
        self.contentView.backgroundColor = UIColorYellow;
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

-(void)updateData {
    [self.button setTitle:@(arc4random() % 200 + 1).stringValue forState:UIControlStateNormal];
}

-(QMUIButton *)button {
    if (!_button) {
        _button = [[QMUIButton alloc] init];
        [_button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_button setBackgroundColor:UIColorGreen];
        _button.layer.borderWidth = 1;
    }
    return _button;
}


@end

@interface ExampleListTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) QMUIGridView *pictureContainer;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ExampleListTableViewCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.pictureContainer];
    [self.collectionView registerClass:[ExampleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(ExampleCollectionViewCell.class)];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    for (int i = 0; i < DefaultPictureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor qmui_randomColor];
        [self.pictureContainer addSubview:imageView];
    }
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SeparatorWidth);
        make.top.equalTo(self.contentView).offset(SeparatorWidth);
        make.right.equalTo(self.contentView).offset(-SeparatorWidth);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SeparatorWidth);
        make.top.equalTo(self.countLabel.mas_bottom).offset(SeparatorWidth);
        make.right.equalTo(self.contentView).offset(-SeparatorWidth);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SeparatorWidth);
        make.right.equalTo(self.contentView).offset(-SeparatorWidth);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(SeparatorWidth);
        make.height.greaterThanOrEqualTo(@(0.0f));
        make.bottom.equalTo(self.contentView).offset(-SeparatorWidth);
    }];
    //    [self.pictureContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.contentView).offset(SeparatorWidth);
    //        make.right.equalTo(self.contentView).offset(-SeparatorWidth);
    //        make.top.equalTo(self.titleLabel.mas_bottom).offset(SeparatorWidth);
    //        make.height.equalTo(@(PictureItemWidth * 3 + SeparatorWidth * 2)).priorityLow();
    //        make.bottom.equalTo(self.contentView).offset(-SeparatorWidth);
    //    }];
}

-(void)updateCellWithModel:(ExampleListModel *)model indexPath:(NSIndexPath *)indexPath {
    [super updateCellWithModel:model indexPath:indexPath];
    self.countLabel.text = NSStringFormat(@"%lu",(unsigned long) model.count);
    self.titleLabel.text = model.title;
    Log(@"1111");
    [self.collectionView reloadData];
    [self.collectionView setNeedsLayout];
    [self.collectionView layoutIfNeeded];
//    //刷新完成，执行后续代码
   CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
              Log(@"height==%f",height);
             if (floor(self.collectionView.qmui_height) != floor(height)) {
                      [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.height.equalTo(@(height + 40));
                             }];
                          
             }

    Log(@"2222");
    dispatch_async(dispatch_get_main_queue(), ^{
     
       

    });
    Log(@"3333");

    //    NSArray *subViewArray = self.pictureContainer.subviews;
    //    CGFloat rowCount = [self rowCount:model.imageArray];
    //    for (int i = 0; i < subViewArray.count; i++) {
    //        UIImageView *imageView = [subViewArray jk_objectWithIndex:i];
    //        [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://mtimg.ruanmei.com/images/todayinhistory/2019/06/12/150426_354.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    //            imageView.image = [image sd_roundedCornerImageWithRadius:20 corners:UIRectCornerAllCorners borderWidth:1 borderColor:[UIColor qmui_randomColor]];
    //        }];
    //        if (i >= model.imageArray.count) {
    //            imageView.hidden = YES;
    //        } else {
    //            imageView.hidden = NO;
    //        }
    //        CGFloat sepHeight = (rowCount - 1) > 0 ? (rowCount - 1) : 0;
    //        [self.pictureContainer mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.equalTo(@(PictureItemWidth * rowCount + sepHeight * SeparatorWidth ));
    //        }];
    //    }
}

#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(40, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arc4random() % 20 + 1;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ExampleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ExampleCollectionViewCell.class) forIndexPath:indexPath];
     Log(@"cellForItemAtIndexPath");
    [cell updateData];
    return cell;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
//        flow.estimatedItemSize = CGSizeMake(100, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.backgroundColor = UIColorBlue;
        _collectionView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _collectionView;
}



- (NSInteger)rowCount:(NSArray *)array {
    NSInteger subviewCount = array.count;
    return subviewCount / 3 + (subviewCount % 3 > 0 ? 1 : 0);
}

-(QMUILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.qmui_lineHeight = 20;
    }
    return _titleLabel;
}

-(QMUIGridView *)pictureContainer {
    if (!_pictureContainer) {
        _pictureContainer = [[QMUIGridView alloc] initWithColumn:3 rowHeight:(SCREEN_WIDTH - SeparatorWidth*4) / 3];
        //        _pictureContainer.backgroundColor = UIColorGreen;
        _pictureContainer.separatorWidth = SeparatorWidth;
        _pictureContainer.separatorColor = UIColorClear;
    }
    return _pictureContainer;
}

-(QMUILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[QMUILabel alloc] init];
        _countLabel.numberOfLines = 0;
    }
    return _countLabel;
}



@end
