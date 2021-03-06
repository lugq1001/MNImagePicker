//
//  ViewController.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "ViewController.h"
#import "MNImagePicker.h"

@interface ViewController () <MNImagePickerDelegate>

@property (nonatomic) MNImagePicker *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MNImagePickerConfig *config = [MNImagePickerConfig defaultConfig];
    config.maxCount = 9;
    _picker = [[MNImagePicker alloc] init:self config:config delegate:self];
}

- (IBAction)choose:(id)sender {
    [_picker startPicker];
}

- (IBAction)album:(id)sender {
    _picker.config.currnetCount = 3;
    [_picker startPickerWithAlbums];
}

- (IBAction)capture:(id)sender {
    [_picker startPickerWithCamera];
}


- (void)imagePickerDidFinishedFromAlbum:(NSArray<ALAsset *> *)assets {
    NSLog(@"选择相册照片:%ld",assets.count);
}

- (void)imagePickerDidFinishedFromCamera:(UIImage *)image {
    NSLog(@"拍摄照片:%d",image == nil ? 0 : 1);
}




@end
