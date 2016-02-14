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

- (void)imagePickerDidFinishedFromAlbum;
- (void)imagePickerDidFinishedFromCamera;

@end

@interface MNImagePicker : NSObject

@property (nonatomic) id<MNImagePickerDelegate> delegate;
@property (nonatomic) MNImagePickerConfig *config;
@property (nonatomic) UIImage *imageByCamera;
@property (nonatomic) NSArray *images;


- (instancetype)init:(UIViewController *)controller config:(MNImagePickerConfig *)config delegate:(id<MNImagePickerDelegate>)delegate;

- (void)startPicker;


+ (ALAssetsLibrary *)assetsLib;

/**
 *  清除拍照图片
 */
- (void)clearCameraImage;

@end
