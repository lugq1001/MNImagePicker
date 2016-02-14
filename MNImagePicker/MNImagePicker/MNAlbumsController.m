//
//  MNAlbumsController.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "MNAlbumsController.h"
#import "MNPhotosController.h"
#import "MNAlbumCell.h"
#import "MNImagePickerHelper.h"

@interface MNAlbumsController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *iTableView;
@property (nonatomic) NSArray *albums;

@end

@implementation MNAlbumsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setTitle:@"我的相册"];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = left;
    _albums = @[];
    [MNImagePickerHelper loadAlbums:^(NSArray *albums) {
        _albums = albums;
        [_iTableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_showPhotos) {
        [self pushToPhotosController:nil animation:false];
        _showPhotos = false;
    }
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)pushToPhotosController:(ALAssetsGroup *)album animation:(BOOL)animation {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MNImagePicker" bundle:[NSBundle mainBundle]];
    MNPhotosController *ctl = [sb instantiateViewControllerWithIdentifier:@"MNPhotosController"];
    ctl.album = album;
    ctl.picker = self.picker;
    [self.navigationController pushViewController:ctl animated:animation];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MNAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MNAlbumCell" forIndexPath:indexPath];
    ALAssetsGroup *album = [_albums objectAtIndex:indexPath.row];
    NSString *name = [album valueForProperty:ALAssetsGroupPropertyName];
    NSInteger count = [album numberOfAssets];
    CGImageRef poster = [album posterImage];
    cell.iCoverImage.image = [UIImage imageWithCGImage:poster];
    cell.iNameLabel.text = [NSString stringWithFormat:@"%@(%ld)", name, count];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self pushToPhotosController:_albums[indexPath.row] animation:true];
}

@end













