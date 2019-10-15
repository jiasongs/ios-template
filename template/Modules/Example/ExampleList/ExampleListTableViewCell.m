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

@interface ExampleListTableViewCell ()

@property (nonatomic, strong) QMUIGridView *pictureContainer;
@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation ExampleListTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.pictureContainer];
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
    [self.pictureContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SeparatorWidth);
        make.right.equalTo(self.contentView).offset(-SeparatorWidth);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(SeparatorWidth);
        make.height.equalTo(@(PictureItemWidth * 3 + SeparatorWidth * 2)).priorityLow();
        make.bottom.equalTo(self.contentView).offset(-SeparatorWidth);
    }];
}

-(void)updateCellWithModel:(ExampleListModel *)model indexPath:(NSIndexPath *)indexPath {
    [super updateCellWithModel:model indexPath:indexPath];
    self.countLabel.text = NSStringFormat(@"%lu",(unsigned long) model.count);
    self.titleLabel.text = model.title;
    NSArray *subViewArray = self.pictureContainer.subviews;
    CGFloat rowCount = [self rowCount:model.imageArray];
    for (int i = 0; i < subViewArray.count; i++) {
        UIImageView *imageView = [subViewArray jk_objectWithIndex:i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://mtimg.ruanmei.com/images/todayinhistory/2019/06/12/150426_354.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            imageView.image = [image sd_roundedCornerImageWithRadius:20 corners:UIRectCornerAllCorners borderWidth:1 borderColor:[UIColor qmui_randomColor]];
        }];
        if (i >= model.imageArray.count) {
            imageView.hidden = YES;
        } else {
            imageView.hidden = NO;
        }
        CGFloat sepHeight = (rowCount - 1) > 0 ? (rowCount - 1) : 0;
        [self.pictureContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(PictureItemWidth * rowCount + sepHeight * SeparatorWidth ));
        }];
    }
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
