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
@property (weak, nonatomic) IBOutlet UIButton *iCompleteButton;
@property (weak, nonatomic) IBOutlet UILabel *iCountLabel;
@property (weak, nonatomic) IBOutlet UIView *iCountView;

@property (nonatomic) NSArray *photos;

@end

@implementation MNPhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _iCollectionView.backgroundColor = [UIColor whiteColor];
    _iCollectionView.collectionViewLayout = [self layout];
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
        if (_photos.count > 0) {
            [_iCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_photos.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:false];
        }
        
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
    [self dismiss];
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
    UIImage *img = [[UIImage alloc] initWithCGImage:ref];
    cell.iImageView.image = img;
    cell.iCheckImage.hidden = ![self hasSelected:result];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ALAsset *photo = [_photos objectAtIndex:indexPath.row];
    if (_picker.config.maxCount == 1) {
        _picker.images = [[NSMutableArray alloc] initWithArray:@[photo]];
        [self dismiss];
    } else {
        if ([self hasSelected:photo]) {
            [self removeSelected:photo];
        } else {
            if (_picker.images.count < _picker.config.maxCount) {
                [_picker.images addObject:photo];
            }
        }
        [self updateCount];
        [_iCollectionView reloadData];
    }
}

#pragma mark - Helper
- (UICollectionViewFlowLayout *)layout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat dWidth = [UIScreen mainScreen].bounds.size.width;
    NSUInteger col = 4;
    CGFloat spacing = 4.0;
    CGFloat itemW = (dWidth - spacing * (col + 1)) / col;
    layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    layout.itemSize = CGSizeMake(itemW, itemW);
    layout.minimumInteritemSpacing = spacing;
    layout.minimumLineSpacing = spacing;
    return layout;
}

- (BOOL)hasSelected:(ALAsset *)photo {
    NSURL *u = photo.defaultRepresentation.url;
    for (ALAsset *a in _picker.images) {
        if ([a.defaultRepresentation.url isEqual:u]) {
            return true;
        }
    }
    return false;
}

- (void)removeSelected:(ALAsset *)photo {
    NSURL *u = photo.defaultRepresentation.url;
    for (NSUInteger i = 0; i < _picker.images.count; i++) {
        ALAsset *a = _picker.images[i];
        if ([a.defaultRepresentation.url isEqual:u]) {
            [_picker.images removeObjectAtIndex:i];
        }
    }
}

@end












