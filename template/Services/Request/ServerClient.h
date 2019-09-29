//
//  ServerClient.h
//  template
//
//  Created by jiasong on 2019/4/13.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "ServerRequest.h"
#import "ServerResponse.h"

typedef void (^_Nullable ServerProgress)(NSProgress * _Nonnull progress);
typedef void (^_Nullable ServerCompleted)(ServerResponse * _Nonnull response);


@interface ServerClient : NSObject

+ (instancetype _Nullable)sharedClient;


-(NSURLSessionDataTask *_Nullable)getWithRequest:(ServerRequest *_Nullable)request
                               progress:(nullable ServerProgress)progress
                              completed:(ServerCompleted)completed;

-(NSURLSessionDataTask *_Nullable)postWithRequest:(ServerRequest *_Nullable)request
                                progress:(nullable ServerProgress)progress
                               completed:(ServerCompleted)completed;

-(NSURLSessionDataTask *_Nullable)uploadWithRequest:(ServerRequest *_Nullable)request
                                  progress:(nullable ServerProgress)progress
                                 completed:(ServerCompleted)completed;


@end


