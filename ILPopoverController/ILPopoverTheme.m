//
//  ILPopoverTheme.m
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-27.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverTheme.h"

@implementation ILPopoverTheme

- (id)init
{
    if (self = [super init])
    {
        _arrowSize = CGSizeMake(30, 15);
        _backgroundColor = [UIColor colorWithRed:32.0 / 255.0 green:32.0 / 255.0 blue:32.0 / 255.0 alpha:1];
        _cornerRadius = 5;
        _shadowColor = [UIColor blackColor];
        _shadowRadius = 2;
        _shadowOffset = CGSizeMake(0, 2);
        _shadowOpacity = 0.5;
    }
    
    return self;
}

@end
