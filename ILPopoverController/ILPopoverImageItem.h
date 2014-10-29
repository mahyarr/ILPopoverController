//
//  ILPopoverImageItem.h
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-26.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverItem.h"

@interface ILPopoverImageItem : ILPopoverItem

@property (nonatomic, strong) UIImage *image;
@property (nonatomic) UIViewContentMode contentMode;

+ (instancetype)newImageItemWithImage:(UIImage *)image;

@end
