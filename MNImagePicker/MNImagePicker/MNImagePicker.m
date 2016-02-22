//
//  MNImagePicker.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "MNImagePicker.h"
#import <AVFoundation/AVFoundation.h>
#import "MNAlbumsController.h"

@interface MNImagePicker () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic) UIViewController *container;

@end

@implementation MNImagePicker

static ALAssetsLibrary *assetsLibrary;

- (instancetype)init:(UIViewController *)controller config:(MNImagePickerConfig *)config delegate:(id<MNImagePickerDelegate>)delegate
{
    if ([super init]) {
        self.delegate = delegate;
        self.container = controller;
        self.config = config;
        if (assetsLibrary == nil) {
            assetsLibrary = [ALAssetsLibrary new];
        }
        return self;
    }
    return nil;
}

- (void)startPicker
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [sheet showInView:_container.view];
}

- (void)startPickerWithAlbums:(NSUInteger)pickCount
{
    NSLog(@"从手机相册选择");
    if (![self checkAlbumsPermission]) {
        NSString *tips = kAlbumPermissionTips;
        [self showMessage:tips];
        return;
    }
    [self pickWithAlbum];
}

- (void)startPickerWithCamera
{
    NSLog(@"拍照");
    if (![self checkCameraPermission]) {
        NSString *tips = kCameraPermissionTips;
        [self showMessage:tips];
        return;
    }
    [self pickWithCamera];
}

+ (ALAssetsLibrary *)assetsLib
{
    if (assetsLibrary == nil) {
        assetsLibrary = [ALAssetsLibrary new];
    }
    return assetsLibrary;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self startPickerWithCamera];
            break;
        case 1:
            [self startPickerWithAlbums:0];
            break;
        case 2:
            NSLog(@"取消");
            break;
        default:
            break;
    }
}

- (void)pickWithCamera
{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = _config.allowCameraEditing;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [_container presentViewController:picker animated:true completion:^{
        
    }];
}

- (void)pickWithAlbum
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MNImagePicker" bundle:[NSBundle mainBundle]];
    UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"MNImagePickerNavi"];
    
    MNAlbumsController *ctl = navi.viewControllers.firstObject;
    ctl.showPhotos = true;
    ctl.picker = self;
    [_container presentViewController:navi animated:true completion:^{
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *result = [info objectForKey:_config.allowCameraEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(result, _config.compressQuality);
    result = [UIImage imageWithData:imageData];
    [_delegate imagePickerDidFinishedFromCamera:result];
    [picker dismissViewControllerAnimated:true completion:^{
        NSLog(@"照片文件大小：%ld，宽：%f, 高：%f", [imageData length] / 1024, result.size.width,result.size.height);
    }];
}

#pragma mark - 权限相关

- (BOOL)checkCameraPermission
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
    case AVAuthorizationStatusAuthorized://已经获得了许可
        return true;
    case AVAuthorizationStatusDenied://被拒绝了，不能打开
        return false;
    case AVAuthorizationStatusNotDetermined://不确定是否获得了许可
        return true;
    case AVAuthorizationStatusRestricted://受限制：已经询问过是否获得许可但被拒绝
        return false;
    }
}

// 相册权限
- (BOOL)checkAlbumsPermission
{
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    switch (authStatus) {
    case ALAuthorizationStatusAuthorized://已经获得了许可
        return true;
    case ALAuthorizationStatusDenied://被拒绝了，不能打开
        return false;
    case ALAuthorizationStatusNotDetermined://不确定是否获得了许可
        return true;
    case ALAuthorizationStatusRestricted://受限制：已经询问过是否获得许可但被拒绝
        return false;
    }
}


#pragma mark - Helper
- (void)showMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
}


@end
