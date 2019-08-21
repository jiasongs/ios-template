//
//  LogManager.h
//  MagicMiss
//
//  Created by jiasong on 2019/4/22.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogManager : NSObject

+ (nonnull instancetype)sharedInstance;

- (void)printLogWithFile:(nullable const char *)file line:(int)line func:(nonnull const char *)func logString:(nonnull NSString *)logString;


@end

NS_ASSUME_NONNULL_END
