//
//  ServerRequest.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ServerRequestMethod) {
    ServerRequestMethodGet = 0,
    ServerRequestMethodPost,
};

@interface ServerRequest : NSObject
/**
 域名的url
 */
@property(nonatomic, copy) NSString *baseUrl;
/**
 base params
 */
@property(nonatomic, copy) NSDictionary *baseParams;
/**
 当前请求的url
 */
@property(nonatomic, copy) NSString *url;
/**
 当前请求的参数
 */
@property(nonatomic, copy) NSDictionary *params;
/**
 当前的请求方式
 */
@property(nonatomic, assign) ServerRequestMethod method;
/**
 超时时间
 */
@property(nonatomic, assign) NSTimeInterval timeout;

/**
 @return 处理后的Url
 */
-(NSString *)handleRequestUrl;
/**
 @return 处理后的Params
 */
-(NSDictionary *)handleRequestParams;


@end


