//
//  MNPhotosController.h
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNImagePicker.h"

@interface MNPhotosController : UIViewController

@property (nonatomic) MNImagePicker *picker;
@property (nonatomic) ALAssetsGroup *album;

@end

