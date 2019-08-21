//
//  BaseTableViewCell.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "QMUITableViewCell.h"
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : QMUITableViewCell

// 子类重写
-(void)updateCellWithModel:(__kindof BaseModel *)model indexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
