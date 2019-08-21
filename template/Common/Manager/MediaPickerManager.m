//
//  MediaPickerManager.m
//  template
//
//  Created by jiasong on 2019/4/15.
//  Copyright © 2019 jiasong. All rights reserved.
//

#import "MediaPickerManager.h"
#import <TZImagePickerController.h>

@interface MediaPickerManager ()

@end

@implementation MediaPickerManager

+(void)showChoosePickerWithType:(MediaType)mediaType configure:(nullable void(^)(TZImagePickerController *pickerVC))configure completed:(void (^)(NSArray<NSDictionary *> *infos))completed {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] init];
    [self handlePickerAppearance:imagePickerVc];
    if (mediaType == MediaTypeImage) {
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
            NSMutableArray<NSDictionary *> *array = [NSMutableArray array];
            for (UIImage *image in photos) {
                [array jk_addObj:[self handleImageData:image quality:0.7]];
            }
            completed(array);
        }];
    } else {
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = NO;
        [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
            
        }];
    }
    if (configure) {
        configure(imagePickerVc);
    }
    UIViewController *topVC = [QMUIHelper visibleViewController];
    if (topVC) {
        [topVC presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

+(void)handlePickerAppearance:(TZImagePickerController *)pickerVC {
    TZImagePickerController *appearance = [TZImagePickerController appearance];
    pickerVC.maxImagesCount = appearance.maxImagesCount;
    pickerVC.minImagesCount = appearance.minImagesCount;
    pickerVC.naviTitleColor = appearance.naviTitleColor;
    pickerVC.naviTitleFont = appearance.naviTitleFont;
    pickerVC.barItemTextColor = appearance.barItemTextColor;
    pickerVC.barItemTextFont = appearance.barItemTextFont;
    pickerVC.doneBtnTitleStr = appearance.doneBtnTitleStr;
    pickerVC.cancelBtnTitleStr = appearance.cancelBtnTitleStr;
    pickerVC.previewBtnTitleStr = appearance.previewBtnTitleStr;
    pickerVC.fullImageBtnTitleStr = appearance.fullImageBtnTitleStr;
    pickerVC.settingBtnTitleStr = appearance.settingBtnTitleStr;
    pickerVC.processHintStr = appearance.processHintStr;
}

+(NSDictionary *)handleImageData:(UIImage *)image quality:(CGFloat)quality {
    NSMutableDictionary *photo = [NSMutableDictionary dictionary];
    NSData *imageData = UIImageJPEGRepresentation(image, quality);
    [photo setValue:image forKey:@"image"];
    NSURL *urlPath = [self getFileUrl];
    if ([imageData writeToURL:urlPath atomically:YES]) {
         [photo setValue:urlPath.absoluteString forKey:@"path"];
    } else {
        Log(@"保存压缩图片失败%@", urlPath);
    }
    return photo;
}

+(NSURL *)getFileUrl {
    NSString *dirPath = [NSString stringWithFormat:@"%@ImageCaches", NSTemporaryDirectory()];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", [[NSUUID UUID] UUIDString]];
    NSString *filePath = [dirPath stringByAppendingFormat:@"/%@",fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [NSURL fileURLWithPath:filePath];
}

@end

@implementation TZImagePickerController (UIAppearance)

+ (instancetype)appearance {
    static dispatch_once_t onceToken;
    static TZImagePickerController *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[TZImagePickerController alloc] init];
    });
    return instance;
}



@end


