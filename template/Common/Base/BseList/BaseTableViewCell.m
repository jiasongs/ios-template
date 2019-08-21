//
//  BaseTableViewCell.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/5.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)updateCellWithModel:(__kindof BaseModel *)model indexPath:(NSIndexPath *)indexPath {
    
}

@end
