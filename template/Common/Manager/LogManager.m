//
//  LogManager.m
//  MagicMiss
//
//  Created by jiasong on 2019/4/22.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "LogManager.h"

@implementation LogManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static LogManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (void)printLogWithFile:(nullable const char *)file line:(int)line func:(nonnull const char *)func logString:(nonnull NSString *)logString {
#ifdef DEBUG
    NSString *fileString = [NSString stringWithFormat:@"%s",file];
    NSArray *fileArray = [fileString componentsSeparatedByString:@"/"];
    NSString *funcString = [NSString stringWithFormat:@"%s", func];
    NSString *defaultString = [NSString stringWithFormat:@"%@ %@ | %@行 %@",fileArray.lastObject, funcString, @(line), logString];
    NSString *utf8String = [defaultString jk_makeUnicodeToString];
    NSLog(@"%@", utf8String ?: defaultString);
#else
#endif
    
}

@end
