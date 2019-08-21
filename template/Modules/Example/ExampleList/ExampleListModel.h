//
//  ExampleListModel.h
//  template
//
//  Created by jiasong on 2019/6/4.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExampleListModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, assign) NSUInteger count;

@end

NS_ASSUME_NONNULL_END
