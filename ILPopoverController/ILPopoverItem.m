//
//  ILPopoverItem.m
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-26.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverItem.h"

@implementation ILPopoverItem

- (id)init
{
    if (self = [super init])
    {
        _alignment = ILPopoverItemAlignmentLeft;
        _inset = UIEdgeInsetsMake(5, 0, 5, 0);
    }
    
    return self;
}

@end
