//
//  ServerResponse.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSUInteger, ServerResponseCode) {
    ServerResponseCodeSuccess = 0,
    ServerResponseCodeFailure,
};


@interface ServerResponse : BaseModel

/**
 请求成功与否
 */
@property (nonatomic, assign) BOOL successful;
/**
 status值
 */
@property (nonatomic, assign) NSInteger code;
/**
 message值
 */
@property (nullable, nonatomic, copy) NSString *message;
/**
 返回原始数据
 */
@property (nullable, nonatomic, copy) NSDictionary *originalData;
/**
 返回处理后的数据
 */
@property (nullable, nonatomic, copy) NSDictionary *data;
/**
 错误
 */
@property (nullable, nonatomic, copy) NSError *error;
/**
 初始化
 */
-(instancetype)initWithResponseDic:(nullable NSDictionary *)dic error:(nullable NSError *)error;


@end


