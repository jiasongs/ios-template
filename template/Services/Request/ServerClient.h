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

typedef void (^ServerProgress)(NSProgress *progress);
typedef void (^ServerCompleted)(ServerResponse *response);


@interface ServerClient : NSObject

+ (instancetype)sharedClient;


-(NSURLSessionDataTask *)getWithRequest:(ServerRequest *)request
                               progress:(nullable ServerProgress)progress
                              completed:(ServerCompleted)completed;

-(NSURLSessionDataTask *)postWithRequest:(ServerRequest *)request
                                progress:(nullable ServerProgress)progress
                               completed:(ServerCompleted)completed;

-(NSURLSessionDataTask *)uploadWithRequest:(ServerRequest *)request
                                  progress:(nullable ServerProgress)progress
                                 completed:(ServerCompleted)completed;


@end


