//
//  ServerResponse.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ServerResponse.h"

@interface ServerResponse ()


@end

@implementation ServerResponse

-(instancetype)initWithResponseDic:(nullable NSDictionary *)dic error:(nullable NSError *)error {
    if (self = [super init]) {
        [self setResponseData:dic error:error];
    }
    return self;
}

-(void)setResponseData:(NSDictionary *)dic error:(NSError *)error {
    if (error) {
        self.successful = NO;
        self.code = ServerResponseCodeFailure;
        self.message = error.localizedDescription;
        self.originalData = nil;
        self.data = nil;
        self.error = error;
    } else {
        NSInteger responseCode = [dic jk_integerForKey:@"code"];
        NSString *responseMessage = [dic jk_stringForKey:@"message"];
        NSDictionary *responseData = dic;
        if (responseCode == ServerResponseCodeSuccess) {
            self.successful = YES;
        } else {
            self.successful = NO;
        }
        self.code = responseCode;
        self.message = responseMessage;
        self.originalData = responseData;
        self.data = responseData;
        self.error = nil;
    }
}




@end
