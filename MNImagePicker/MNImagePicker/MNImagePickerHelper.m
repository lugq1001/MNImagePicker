//
//  MNImagePickerHelper.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "MNImagePickerHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation MNImagePickerHelper

+ (void)loadAlbums:(void(^)(NSArray *))completion
{
    NSMutableArray *albums = [NSMutableArray new];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group != nil) {
            [albums addObject:group];
        } else {
            completion(albums);
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
                
        }
    };
    [[MNImagePicker assetsLib] enumerateGroupsWithTypes:ALAssetsGroupAll
                                             usingBlock:listGroupBlock
                                           failureBlock:failureBlock];
}


+ (void)loadPhotos:(void(^)(NSArray *))completion
{
    NSMutableArray *photos = [NSMutableArray new];
    NSMutableSet *sets = [NSMutableSet new];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group != nil) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result != nil) {
                    NSURL *uti = [[result defaultRepresentation] url];
                    NSLog(@"%@",uti);
                    if (![sets containsObject:uti]) {
                        [photos addObject:result];
                        [sets addObject:uti];
                    }
                }
            }];
        } else {
            completion(photos);
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
                
        }
    };
    ALAssetsGroupType type = ALAssetsGroupSavedPhotos;
    [[MNImagePicker assetsLib] enumerateGroupsWithTypes:type
                                             usingBlock:listGroupBlock
                                           failureBlock:failureBlock];
}

@end














