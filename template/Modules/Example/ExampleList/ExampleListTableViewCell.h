//
//  ExampleListTableViewCell.h
//  template
//
//  Created by jiasong on 2019/6/4.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ExampleListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExampleListTableViewCell : BaseTableViewCell

@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) QMUILabel *countLabel;
@end

NS_ASSUME_NONNULL_END
