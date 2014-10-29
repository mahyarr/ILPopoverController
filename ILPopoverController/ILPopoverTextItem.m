//
//  ILPopoverTextItem.m
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-26.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverTextItem.h"

@implementation ILPopoverTextItem

+ (instancetype)newTextItemWithAttributedText:(NSAttributedString *)attributedString
{
    ILPopoverTextItem *item = [[ILPopoverTextItem alloc] init];
    [item setAttributedString:attributedString];
    return item;
}

@end
