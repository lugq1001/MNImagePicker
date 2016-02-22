//
//  MNImagePickerConfig.h
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kCameraPermissionTips @"请在『设置』-『隐私』-『照片』选项中，允许本应用访问您的相机";
#define kAlbumPermissionTips @"请在『设置』-『隐私』-『照片』选项中，允许访本应用问您的相册";


@interface MNImagePickerConfig : NSObject

/**
 *  相机拍摄时是否允许编辑
 */
@property (nonatomic) BOOL allowCameraEditing;

/**
 *  图像质量
 */
@property (nonatomic) CGFloat compressQuality;

/**
 *  最多选择图片数
 */
@property (nonatomic) NSUInteger maxCount;

/**
 *  当前图片数
 */
@property (nonatomic) NSUInteger currnetCount;

+ (MNImagePickerConfig *)defaultConfig;

@end




