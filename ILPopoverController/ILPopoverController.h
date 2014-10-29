//
//  ILPopoverController.h
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-25.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILPopoverActionItem.h"
#import "ILPopoverImageItem.h"
#import "ILPopoverTextItem.h"
#import "ILPopoverTheme.h"

@interface ILPopoverController : UIView

@property (nonatomic, strong, readonly) ILPopoverTheme *theme;

- (void)addItem:(ILPopoverItem *)item;
- (void)presentPopoverFromView:(UIView *)view animated:(BOOL)animated;
- (void)dismissPopoverAnimated:(BOOL)animated;

@end
