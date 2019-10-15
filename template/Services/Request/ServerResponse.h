//
//  ServerResponse.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ServerResponseCode) {
    ServerResponseCodeSuccess = 0,
    ServerResponseCodeFailure,
};


@interface ServerResponse : NSObject

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
@property (nullable, nonatomic) NSString *message;
/**
 返回原始数据
 */
@property (nullable, nonatomic) NSDictionary *originalData;
/**
 返回处理后的数据
 */
@property (nullable, nonatomic) id data;
/**
 错误
 */
@property (nullable, nonatomic) NSError *error;
/**
 初始化
 */
-(instancetype)initWithResponseDic:(nullable NSDictionary *)dic error:(nullable NSError *)error;


@end


