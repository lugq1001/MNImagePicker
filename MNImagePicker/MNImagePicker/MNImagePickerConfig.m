//
//  MNImagePickerConfig.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "MNImagePickerConfig.h"

@implementation MNImagePickerConfig

+ (MNImagePickerConfig *)defaultConfig
{
    MNImagePickerConfig *config = [MNImagePickerConfig new];
    config.allowCameraEditing = true;
    config.compressQuality = 0.7;
    config.maxCount = 1;
    return config;
}

@end
