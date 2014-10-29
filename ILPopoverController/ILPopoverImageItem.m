//
//  ILPopoverImageItem.m
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-26.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverImageItem.h"

@implementation ILPopoverImageItem

- (id)init
{
    if (self = [super init])
    {
        _contentMode = UIViewContentModeScaleAspectFill;
    }

    return self;
}

+ (instancetype)newImageItemWithImage:(UIImage *)image
{
    ILPopoverImageItem *item = [[ILPopoverImageItem alloc] init];
    [item setImage:image];
    return item;
}

@end
