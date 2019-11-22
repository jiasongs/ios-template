//
//  ServerClient.m
//  template
//
//  Created by jiasong on 2019/4/13.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ServerClient.h"

const char *SERVER_CONCURRENT = "SERVER_CONCURRENT";

@interface ServerClient ()

@end

@implementation ServerClient

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    static ServerClient *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedClient];
}

-(AFHTTPSessionManager *)createSessionManager:(ServerRequest *)request {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    dispatch_queue_t completionQueue = dispatch_queue_create(SERVER_CONCURRENT, DISPATCH_QUEUE_CONCURRENT);
    manager.completionQueue = completionQueue;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = request.timeout;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return manager;
}

-(NSURLSessionDataTask *)getWithRequest:(ServerRequest *)request
                               progress:(nullable ServerProgress)progress
                              completed:(ServerCompleted)completed {
    request.method = ServerRequestMethodGet;
    AFHTTPSessionManager *manager = [self createSessionManager:request];
    NSString *requestUrl = [request handleRequestUrl];
    NSDictionary *requestParams = [request handleRequestParams];
    NSURLSessionDataTask *dataTask = [manager GET:requestUrl parameters:requestParams progress:progress success:^(NSURLSessionDataTask *task, NSDictionary *responseDic) {
        ServerResponse *response = [[ServerResponse alloc] initWithResponseDic:responseDic error:nil];
        if (completed) {
            completed(response);
        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ServerResponse *response = [[ServerResponse alloc] initWithResponseDic:nil error:error];
        if (completed) {
            completed(response);
        }
    }];
    return dataTask;
}

-(NSURLSessionDataTask *)postWithRequest:(ServerRequest *)request
                               progress:(nullable ServerProgress)progress
                              completed:(ServerCompleted)completed {
    request.method = ServerRequestMethodPost;
    AFHTTPSessionManager *manager = [self createSessionManager:request];
    NSString *requestUrl = [request handleRequestUrl];
    NSDictionary *requestParams = [request handleRequestParams];
    NSURLSessionDataTask *dataTask = [manager POST:requestUrl parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:progress success:^(NSURLSessionDataTask *task, NSDictionary *responseDic) {
        ServerResponse *response = [[ServerResponse alloc] initWithResponseDic:responseDic error:nil];
        if (completed) {
            completed(response);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ServerResponse *response = [[ServerResponse alloc] initWithResponseDic:nil error:error];
        if (completed) {
            completed(response);
        }
    }];
    return dataTask;
}

-(NSURLSessionDataTask *)uploadWithRequest:(ServerRequest *)request
                              progress:(nullable ServerProgress)progress
                             completed:(ServerCompleted)completed {
    request.method = ServerRequestMethodPost;
    AFHTTPSessionManager *manager = [self createSessionManager:request];
    NSString *requestUrl = [request handleRequestUrl];
    NSDictionary *requestParams = [request handleRequestParams];
    NSURLSessionDataTask *dataTask = [manager POST:requestUrl parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *path = [requestParams jk_stringForKey:@"path"];
        [formData appendPartWithFileURL:[NSURL URLWithString:path] name:@"file" error:nil];
    } progress:progress success:^(NSURLSessionDataTask *task,  NSDictionary *responseDic) {
        ServerResponse *response = [[ServerResponse alloc] initWithResponseDic:responseDic error:nil];
        if (completed) {
            completed(response);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ServerResponse *response = [[ServerResponse alloc] initWithResponseDic:nil error:error];
        if (completed) {
            completed(response);
        }
    }];
    return dataTask;
}







@end
