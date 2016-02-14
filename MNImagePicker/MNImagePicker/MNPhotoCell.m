//
//  MNPhotoCell.m
//  MNImagePicker
//
//  Created by 陆广庆 on 16/2/13.
//  Copyright © 2016年 陆广庆. All rights reserved.
//

#import "MNPhotoCell.h"

@implementation MNPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iCheckImage.image = [UIImage imageNamed:@"ic_check.png"];
    _iCheckImage.layer.cornerRadius = _iCheckImage.bounds.size.width / 2;
    _iCheckImage.backgroundColor = [UIColor whiteColor];
    _iCheckImage.hidden = true;
}

@end
