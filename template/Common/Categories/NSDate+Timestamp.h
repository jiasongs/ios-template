//
//  NSDate+Timestamp.h
//  MagicMiss
//
//  Created by jiasong on 2019/5/9.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Timestamp)

+(NSString *)dateWithTimestamp:(NSTimeInterval)timestamp format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
