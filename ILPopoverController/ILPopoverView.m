//
//  ILPopoverView.m
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-25.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverView.h"

#define VIEW_STARTING_TAG 100

# pragma mark - ILPopoverArrowView Interdace

@interface ILPopoverArrowView()

@property (nonatomic, strong) UIColor *arrowColor;
@property (nonatomic, weak) UIView *view;

@end

# pragma mark - ILPopoverView Implementation

@interface ILPopoverView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

# pragma mark - ILPopoverView Implementation

@implementation ILPopoverView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _contentItems = [[NSMutableArray alloc] init];

        _arrowView = [[ILPopoverArrowView alloc] initWithFrame:CGRectZero];
        _arrowView.arrowColor = [UIColor blackColor];

        [self addSubview:_arrowView];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor blackColor];
        _contentView.layer.cornerRadius = 5;
        [_contentView sizeToFit];

        [self addSubview:_contentView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize arrowSize = [self.arrowView intrinsicContentSize];
    CGFloat contentOriginY = 0;
    
    if (self.arrowView.arrowDirection == ILPopoverArrowDirectionUp)
    {
        self.arrowView.frame = CGRectMake(self.arrowOffsetX - arrowSize.width / 2, 0, arrowSize.width, arrowSize.height);
        contentOriginY = CGRectGetMaxY(self.arrowView.frame) - 1;
    }
    
    CGRect contentFrame = self.contentView.frame;
    contentFrame.origin.x = 0;
    contentFrame.origin.y = contentOriginY;
    contentFrame.size.width = self.frame.size.width;

    __block CGFloat lastItemOriginY = 10;

    [self.contentItems enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        
        if ([item isKindOfClass:[ILPopoverTextItem class]])
        {
            UILabel *label = (UILabel *)[self.contentView viewWithTag:idx + 100];
            ILPopoverTextItem *textItem = (ILPopoverTextItem *)item;
            
            if (label)
            {
                [label sizeToFit];
                CGRect labelFrame = label.frame;

                labelFrame.origin.x = 10 + textItem.inset.left;
                labelFrame.origin.y = lastItemOriginY + textItem.inset.top;
                labelFrame.size.width = contentFrame.size.width - 20 - (textItem.inset.left + textItem.inset.right);

                [label setFrame:labelFrame];
                lastItemOriginY = CGRectGetMaxY(label.frame) + textItem.inset.bottom;
            }
        }
        else if ([item isKindOfClass:[ILPopoverImageItem class]])
        {
            UIImageView *imageView = (UIImageView *)[self.contentView viewWithTag:idx + VIEW_STARTING_TAG];
            ILPopoverImageItem *imageItem = (ILPopoverImageItem *)item;

            if (imageView)
            {
                [imageView sizeToFit];
                CGRect imageFrame = imageView.frame;
                
                if (imageItem.alignment == ILPopoverItemAlignmentLeft)
                {
                    imageFrame.origin.x = 10 + imageItem.inset.left;
                }
                else if (imageItem.alignment == ILPopoverItemAlignmentRight)
                {
                    imageFrame.origin.x = CGRectGetMaxX(self.contentView.frame) - CGRectGetWidth(imageView.frame) - 10 - imageItem.inset.right;
                }
                else
                {
                    imageFrame.origin.x = CGRectGetMidX(self.contentView.frame) - CGRectGetWidth(imageView.frame) / 2.0;
                }

                imageFrame.origin.y = lastItemOriginY + imageItem.inset.top;
                
                [imageView setFrame:imageFrame];
                lastItemOriginY = CGRectGetMaxY(imageView.frame) + imageItem.inset.bottom;
            }
        }
    }];
    
    CGFloat maxButtonHeight = 0;
    
    if (self.leftButton)
    {
        ILPopoverActionItem *actionItem = (ILPopoverActionItem *)[self.contentItems objectAtIndex:(self.leftButton.tag - VIEW_STARTING_TAG)];
        [self.leftButton setFrame:CGRectMake(actionItem.inset.left + 10, actionItem.inset.top + lastItemOriginY, actionItem.size.width, actionItem.size.height)];
        
        maxButtonHeight = actionItem.size.height + actionItem.inset.top + actionItem.inset.bottom;
    }
    
    if (self.rightButton)
    {
        ILPopoverActionItem *actionItem = (ILPopoverActionItem *)[self.contentItems objectAtIndex:(self.rightButton.tag - VIEW_STARTING_TAG)];
        [self.rightButton setFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) - actionItem.size.width - actionItem.inset.right - 10, lastItemOriginY + actionItem.inset.top, actionItem.size.width, actionItem.size.height)];
        
        maxButtonHeight = MAX(maxButtonHeight, actionItem.size.height + actionItem.inset.top + actionItem.inset.bottom);
    }
    
    if (self.middleButton)
    {
        ILPopoverActionItem *actionItem = (ILPopoverActionItem *)[self.contentItems objectAtIndex:(self.middleButton.tag - VIEW_STARTING_TAG)];
        self.middleButton.center = CGPointMake(self.contentView.center.x, lastItemOriginY + actionItem.inset.top + CGRectGetHeight(self.middleButton.frame) / 2);
        
        maxButtonHeight = MAX(maxButtonHeight, actionItem.size.height + actionItem.inset.top + actionItem.inset.bottom);
    }

    contentFrame.size.height = lastItemOriginY + maxButtonHeight + 10;
    self.contentView.frame = contentFrame;
    
    if (self.arrowView.arrowDirection == ILPopoverArrowDirectionDown)
    {
        self.arrowView.frame = CGRectMake(self.arrowOffsetX - arrowSize.width / 2, CGRectGetMaxY(self.contentView.frame) - 1, arrowSize.width, arrowSize.height);
    }
    
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.arrowView.frame) + CGRectGetHeight(self.contentView.frame));
    
    CGPoint topCenter = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame));
    [self.layer setAnchorPoint:CGPointMake(0.5, 0)];
    [self.layer setPosition:topCenter];
}

- (void)addAction:(ILPopoverActionItem *)actionItem
{
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setFrame:CGRectMake(0, 0, actionItem.size.width, actionItem.size.height)];
    [actionButton setBackgroundColor:actionItem.backgroundColor];
    [actionButton setTitle:actionItem.title forState:UIControlStateNormal];
    [actionButton setTitleColor:actionItem.titleColor forState:UIControlStateNormal];
    [actionButton setTitleColor:actionItem.titleHighlightedColor forState:UIControlStateHighlighted];
    [actionButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [actionButton.layer setCornerRadius:5];
    [actionButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
    [actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton setTag:self.contentItems.count + VIEW_STARTING_TAG];

    switch (actionItem.alignment) {
        case ILPopoverItemAlignmentLeft:
            self.leftButton = actionButton;
            break;
        
        case ILPopoverItemAlignmentCenter:
            self.middleButton = actionButton;
            break;
        
        case ILPopoverItemAlignmentRight:
            self.rightButton = actionButton;
            break;
    }

    [self.contentItems addObject:actionItem];
    [self.contentView addSubview:actionButton];
}

- (void)addText:(ILPopoverTextItem *)textItem
{
    NSAssert(textItem.attributedString != nil, @"attributedString property cannot be nil");
    
    UILabel *label = [[UILabel alloc] init];
    [label setAttributedText:textItem.attributedString];
    [label setNumberOfLines:0];
    [label setTag:self.contentItems.count + VIEW_STARTING_TAG];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
 
    [self.contentItems addObject:textItem];
    [self.contentView addSubview:label];
}

- (void)addImage:(ILPopoverImageItem *)imageItem
{
    NSAssert(imageItem.image != nil, @"image property cannot be nil");

    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageItem.image];
    [imageView setContentMode:imageItem.contentMode];
    [imageView setTag:self.contentItems.count + VIEW_STARTING_TAG];

    [self.contentItems addObject:imageItem];
    [self.contentView addSubview:imageView];
}

- (void)setArrowOffsetX:(CGFloat)arrowOffsetX
{
    _arrowOffsetX = arrowOffsetX;
    [self setNeedsLayout];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [self willChangeValueForKey:@"backgroundColor"];

    [self.arrowView setArrowColor:backgroundColor];
    [self.contentView setBackgroundColor:backgroundColor];

    [self didChangeValueForKey:@"backgroundColor"];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.contentView.layer.cornerRadius = cornerRadius;
}

- (void)buttonHighlight:(UIButton *)button
{
    ILPopoverActionItem *item = self.contentItems[button.tag - VIEW_STARTING_TAG];
    
    if (item && [item isKindOfClass:[ILPopoverActionItem class]])
    {
        [button setBackgroundColor:item.highlightedColor];
    }
}

- (void)actionButtonPressed:(UIButton *)button
{
    id item = self.contentItems[button.tag - VIEW_STARTING_TAG];
    
    if (item && [item isKindOfClass:[ILPopoverActionItem class]])
    {
        ILPopoverActionItem *actionItem = (ILPopoverActionItem *)item;

        [button setBackgroundColor:actionItem.backgroundColor];

        if (actionItem.selectionHandler)
        {
            actionItem.selectionHandler();
        }
    }
}

@end

# pragma mark - ILPopoverArrowView Implementation

@implementation ILPopoverArrowView

- (CGSize)intrinsicContentSize
{
    return self.arrowSize;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])

    {        [self setContentMode:UIViewContentModeRedraw];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setArrowSize:CGSizeMake(0, 0)];
    }
    
    return self;
}

- (void)setArrowSize:(CGSize)arrowSize
{
    _arrowSize = arrowSize;
    [self setNeedsDisplay];
}

- (void)setArrowColor:(UIColor *)arrowColor
{
    _arrowColor = arrowColor;
    [self setNeedsDisplay];
}

- (void)setArrowDirection:(ILPopoverArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    
    if (self.arrowDirection == ILPopoverArrowDirectionDown)
    {
        CGContextMoveToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));        // Bottom middle
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));     // Top right
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));     // Top left
    }
    else
    {
        CGContextMoveToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect));        // Top middle
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));     // Bottom right
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));     // Bottom left
    }
    CGContextClosePath(ctx);

    CGFloat red, green, blue, alpha;
    [self.arrowColor getRed:&red green:&green blue:&blue alpha:&alpha];

    CGContextSetRGBFillColor(ctx, red, green, blue, alpha);
    CGContextFillPath(ctx);
}

@end