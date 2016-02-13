//
//  MNImagePickerHelper.h
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNImagePicker.h"

@interface MNImagePickerHelper : NSObject

+ (void)loadAlbums:(void(^)(NSArray *))completion;
+ (void)loadPhotos:(void(^)(NSArray *))completion;

@end
