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
@property (weak, nonatomic) IBOutlet UIButton *iCompleteButton;
@property (weak, nonatomic) IBOutlet UILabel *iCountLabel;
@property (weak, nonatomic) IBOutlet UIView *iCountView;


@end

@implementation MNPhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _iCollectionView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.album != nil) {
        self.title = [_album valueForProperty:ALAssetsGroupPropertyName];
    } else {
        self.title = @"我的照片";
    }
    if (_picker.config.maxCount == 1) {
        _iCountView.hidden = true;
        _iCollectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    } else {
        _iCountView.hidden = false;
        _iCollectionView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
    }
    [self updateCount];
    _photos = @[];
    [MNImagePickerHelper loadPhotos:_album completion:^(NSArray *photos) {
        _photos = photos;
        [_iCollectionView reloadData];
    }];
}

- (void)dismiss {
    [_picker.delegate imagePickerDidFinishedFromAlbum];
    [self.navigationController dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)updateCount {
    NSUInteger max = _picker.config.maxCount;
    NSUInteger current = _picker.images.count;
    _iCountLabel.text = [NSString stringWithFormat:@"%ld/%ld", current , max];
}

- (IBAction)complete:(UIButton *)sender {
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_picker.config.maxCount == 1) {
        _picker.images = @[_photos[indexPath.row]];
        [self dismiss];
    } else {
        
    }
}


@end












