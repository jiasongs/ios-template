//
//  MediaPickerManager.h
//  template
//
//  Created by jiasong on 2019/4/15.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TZImagePickerController.h>

typedef NS_ENUM(NSUInteger, MediaType) {
    MediaTypeVideo,
    MediaTypeImage
};

@interface MediaPickerManager : NSObject

+(void)showChoosePickerWithType:(MediaType)mediaType
                      configure:(nullable void(^)(TZImagePickerController *pickerVC))configure
                      completed:(void (^)(NSArray<NSDictionary *> *infos))completed;

@end

@interface TZImagePickerController(appearance)

+ (instancetype)appearance;

@end


