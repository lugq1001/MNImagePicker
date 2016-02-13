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


@interface MNImagePicker : NSObject

@property (nonatomic) UIImage *imageByCamera;


- (instancetype)init:(UIViewController *)controller config:(MNImagePickerConfig *)config;

- (void)startPicker;


+ (ALAssetsLibrary *)assetsLib;

/**
 *  清除拍照图片
 */
- (void)clearCameraImage;

@end
