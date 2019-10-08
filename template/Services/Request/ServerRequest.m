//
//  ServerRequest.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "ServerRequest.h"

@interface ServerRequest ()

@end

@implementation ServerRequest

-(instancetype)init {
    self = [super init];
    if (self) {
        _baseUrl = NSStringFormat(@"%@/%@", Host, Api);
        _timeout = 15;
        _baseParams = @{};
    }
    return self;
}

-(NSString *)handleRequestUrl {
    if (self.baseUrl && self.baseUrl.length > 0) {
        return NSStringFormat(@"%@/%@", self.baseUrl, self.url);
    } else {
        return self.url;
    }
}

-(NSDictionary *)handleRequestParams {
    if (self.baseParams) {
        return [self.baseParams jk_dictionaryByMergingWith:self.params];
    } else {
        return self.params;
    }
}

@end
