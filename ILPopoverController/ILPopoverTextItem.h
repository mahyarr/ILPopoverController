//
//  ILPopoverTextItem.h
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-26.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverItem.h"

@interface ILPopoverTextItem : ILPopoverItem

@property (nonatomic, strong) NSAttributedString *attributedString;

+ (instancetype)newTextItemWithAttributedText:(NSAttributedString *)attributedString;

@end
