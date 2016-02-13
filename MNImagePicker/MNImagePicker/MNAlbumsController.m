//
//  MNAlbumsController.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "MNAlbumsController.h"
#import "MNPhotosController.h"

@interface MNAlbumsController ()

@end

@implementation MNAlbumsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setTitle:@"我的相册"];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_showPhotos) {
        [self pushToPhotosController];
        _showPhotos = false;
    }
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)pushToPhotosController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MNImagePicker" bundle:[NSBundle mainBundle]];
    MNPhotosController *ctl = [sb instantiateViewControllerWithIdentifier:@"MNPhotosController"];
    [self.navigationController pushViewController:ctl animated:false];
}

@end
