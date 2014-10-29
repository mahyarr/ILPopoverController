//
//  ILPopoverActionItem.h
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-26.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverItem.h"

typedef void (^selectionHandler) (void);

@interface ILPopoverActionItem : ILPopoverItem

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleHighlightedColor;
@property (nonatomic, copy)  void (^selectionHandler)(void);

+ (instancetype)newActionButtonWithTitle:(NSString *)title selectionHandler:(void (^)(void))selectionHandler;
+ (instancetype)newActionButtonWithTitle:(NSString *)title alignment:(ILPopoverItemAlignment)alignment selectionHandler:(void (^)(void))selectionHandler;

@end
