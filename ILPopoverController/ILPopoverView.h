//
//  ILPopoverView.h
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-25.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverActionItem.h"
#import "ILPopoverImageItem.h"
#import "ILPopoverTextItem.h"
#import "ILPopoverTheme.h"

typedef NS_ENUM(NSUInteger, ILPopoverArrowDirection) {
    ILPopoverArrowDirectionUp,
    ILPopoverArrowDirectionDown
};

@interface ILPopoverArrowView : UIView

@property (nonatomic) CGSize arrowSize;
@property (nonatomic) ILPopoverArrowDirection arrowDirection;

@end

@interface ILPopoverView : UIView

@property (nonatomic, strong, readonly) ILPopoverArrowView *arrowView;
@property (nonatomic, strong, readonly) NSMutableArray *contentItems;
@property (nonatomic) CGFloat arrowOffsetX;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) UIEdgeInsets contentInset;

- (void)addText:(ILPopoverTextItem *)textItem;
- (void)addImage:(ILPopoverImageItem *)imageItem;
- (void)addAction:(ILPopoverActionItem *)actionItem;

@end
