//
//  NSDate+Timestamp.m
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "NSDate+Timestamp.h"

@implementation NSDate (Timestamp)

+(NSString *)dateWithTimestamp:(NSTimeInterval)timestamp format:(NSString *)format {
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [timeDate jk_stringWithFormat:format];
}

@end
