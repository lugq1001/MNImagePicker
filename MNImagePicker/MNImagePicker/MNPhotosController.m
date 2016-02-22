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

@property (nonatomic) NSArray *allPhotos;

@end

@implementation MNPhotosController

static UIImage *checkImage;
static UIImage *checkedImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    checkImage = [UIImage imageNamed:@"mn_ic_uncheck.png"];
    checkedImage = [UIImage imageNamed:@"mn_ic_check.png"];
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
    _allPhotos = @[];
    [MNImagePickerHelper loadPhotos:_album completion:^(NSArray *photos) {
        _allPhotos = photos;
        [_iCollectionView reloadData];
        if (_allPhotos.count > 0) {
            [_iCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_allPhotos.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:false];
        }
        
    }];
}

- (void)dismiss {
    [_picker.delegate imagePickerDidFinishedFromAlbum:_albumCtl.images];
    [self.navigationController dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)updateCount {
    NSUInteger max = _picker.config.maxCount;
    NSUInteger current = _albumCtl.images.count + _picker.config.currnetCount;
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
    return _allPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MNPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MNPhotoCell" forIndexPath:indexPath];
    ALAsset *result = [_allPhotos objectAtIndex:indexPath.row];
    CGImageRef ref = [result thumbnail];
    UIImage *img = [[UIImage alloc] initWithCGImage:ref];
    cell.iImageView.image = img;
    if ([self hasSelected:result]) {
        cell.iCheckImage.image = checkedImage;
    } else {
        cell.iCheckImage.image = checkImage;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ALAsset *photo = [_allPhotos objectAtIndex:indexPath.row];
    if (_picker.config.maxCount == 1) {
        _albumCtl.images = [[NSMutableArray alloc] initWithArray:@[photo]];
        [self dismiss];
    } else {
        if ([self hasSelected:photo]) {
            [self removeSelected:photo];
        } else {
            if (_albumCtl.images.count + _picker.config.currnetCount < _picker.config.maxCount) {
                [_albumCtl.images addObject:photo];
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
    for (ALAsset *a in _albumCtl.images) {
        if ([a.defaultRepresentation.url isEqual:u]) {
            return true;
        }
    }
    return false;
}

- (void)removeSelected:(ALAsset *)photo {
    NSURL *u = photo.defaultRepresentation.url;
    for (NSUInteger i = 0; i < _albumCtl.images.count; i++) {
        ALAsset *a = _albumCtl.images[i];
        if ([a.defaultRepresentation.url isEqual:u]) {
            [_albumCtl.images removeObjectAtIndex:i];
        }
    }
}

@end












