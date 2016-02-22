//
//  MNImagePicker.h
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MNImagePickerConfig.h"

@protocol MNImagePickerDelegate

- (void)imagePickerDidFinishedFromAlbum:(NSArray<ALAsset *> *)assets;
- (void)imagePickerDidFinishedFromCamera:(UIImage *)image;

@end

@interface MNImagePicker : NSObject

@property (nonatomic) id<MNImagePickerDelegate> delegate;
@property (nonatomic) MNImagePickerConfig *config;

- (instancetype)init:(UIViewController *)controller config:(MNImagePickerConfig *)config delegate:(id<MNImagePickerDelegate>)delegate;

- (void)startPicker;


+ (ALAssetsLibrary *)assetsLib;

/**
 *  选测选取
 */
- (void)startPickerWithAlbums:(NSUInteger)pickCount;
/**
 *  相机拍照
 */
- (void)startPickerWithCamera;

@end
