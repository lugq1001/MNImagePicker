//
//  ViewController.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "ViewController.h"
#import "MNImagePicker.h"

@interface ViewController ()

@property (nonatomic) MNImagePicker *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _picker = [[MNImagePicker alloc] init:self config:[MNImagePickerConfig defaultConfig]];
}

- (IBAction)choose:(id)sender {
    [_picker startPicker];
}


@end
