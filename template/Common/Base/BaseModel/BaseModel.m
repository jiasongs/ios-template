//
//  BaseModel.m
//  MagicMiss
//
//  Created by jiasong on 2019/4/30.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "BaseModel.h"

@interface BaseModel ()

@end

@implementation BaseModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"nid":@"id"}];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}


@end
