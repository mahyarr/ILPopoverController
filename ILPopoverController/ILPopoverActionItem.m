//
//  ILPopoverActionItem.m
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-26.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverActionItem.h"

@implementation ILPopoverActionItem

- (id)init
{
    if (self = [super init])
    {
        [self setSize:CGSizeMake(100, 25)];
        [self setInset:UIEdgeInsetsMake(15, 0, 5, 0)];
        _backgroundColor = [UIColor colorWithRed:28.0 / 255.0 green:180.0 / 255.0 blue:74.0 / 255.0 alpha:1];
        _highlightedColor = [UIColor colorWithRed:123.0 / 255.0 green:123.0 / 255.0 blue:123.0 / 255.0 alpha:1];
        _titleColor = [UIColor whiteColor];
        _titleHighlightedColor = [UIColor whiteColor];
    }
    
    return self;
}

+ (instancetype)newActionButtonWithTitle:(NSString *)title selectionHandler:(void (^)(void))selectionHandler
{
    return [self newActionButtonWithTitle:title alignment:ILPopoverItemAlignmentCenter selectionHandler:selectionHandler];
}

+ (instancetype)newActionButtonWithTitle:(NSString *)title alignment:(ILPopoverItemAlignment)alignment selectionHandler:(void (^)(void))selectionHandler
{
    ILPopoverActionItem *item = [[ILPopoverActionItem alloc] init];
    [item setTitle:title];
    [item setAlignment:alignment];
    [item setSelectionHandler:selectionHandler];
    
    return item;
}

@end
