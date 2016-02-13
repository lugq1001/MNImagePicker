//
//  MNPhotosController.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "MNPhotosController.h"
#import "MNPhotoCell.h"
#import "MNImagePickerHelper.h"

@interface MNPhotosController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *iCollectionView;
@property (nonatomic) NSArray *photos;

@end

@implementation MNPhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _iCollectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"我的照片";
    _photos = @[];
    [MNImagePickerHelper loadPhotos:^(NSArray *photos) {
        _photos = photos;
        [_iCollectionView reloadData];
    }];
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MNPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MNPhotoCell" forIndexPath:indexPath];
    ALAsset *result = [_photos objectAtIndex:indexPath.row];
    CGImageRef ref = [result thumbnail];
    UIImage *img = [[UIImage alloc]initWithCGImage:ref];
    cell.iImageView.image = img;
    return cell;
}


@end












