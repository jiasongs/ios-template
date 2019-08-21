//
//  BaseCollectionViewCell.h
//  template
//
//  Created by jiasong on 2019/5/30.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"


@interface BaseCollectionViewCell : UICollectionViewCell

// 子类重写
-(void)updateCellWithModel:(__kindof BaseModel *)model indexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@end


