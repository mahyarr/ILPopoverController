//
//  ILPopoverController.m
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-25.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import "ILPopoverController.h"
#import "ILPopoverView.h"

@interface ILPopoverController ()

@property (nonatomic, strong) ILPopoverView *popoverView;
@property (nonatomic, weak) UIWindow *applicationWindow;
@property (nonatomic, weak) UIView *view;

@end

@implementation ILPopoverController

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use init for initialization, mmkay?");
    return nil;
}

- (id)init
{
    if (self = [super initWithFrame:CGRectZero])
    {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self setAlpha:1];
        
        _theme = [[ILPopoverTheme alloc] init];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped)];
        [self addGestureRecognizer:tapGesture];

        _popoverView = [[ILPopoverView alloc] initWithFrame:CGRectZero];
        [_popoverView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_popoverView setAlpha:0];
        [_popoverView.arrowView setArrowSize:self.theme.arrowSize];
        [self addSubview:self.popoverView];
        
        UITapGestureRecognizer *popoverTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
        [_popoverView addGestureRecognizer:popoverTapGesture];
        
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            if (window.windowLevel == UIWindowLevelNormal)
            {
                self.applicationWindow = window;
                break;
            }
        }
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = self.applicationWindow.bounds;
    
    CGRect popoverFrame = self.popoverView.frame;
    popoverFrame.origin.x = 20;
    popoverFrame.size.width = self.frame.size.width - 40;
    [self.popoverView setFrame:popoverFrame];

    if (self.view)
    {
        CGRect relativeFrame = [self.view convertRect:self.view.bounds toView:self];
        [self.popoverView setArrowOffsetX:(CGRectGetMidX(relativeFrame) - CGRectGetMinX(self.popoverView.frame))];
    }
}

- (void)backgroundTapped
{
    [self dismissPopoverAnimated:YES];
}

- (void)addItem:(ILPopoverItem *)item
{
    if ([item isKindOfClass:[ILPopoverImageItem class]])
    {
        [self.popoverView addImage:(ILPopoverImageItem *)item];
    }
    else if ([item isKindOfClass:[ILPopoverTextItem class]])
    {
        [self.popoverView addText:(ILPopoverTextItem *)item];
    }
    else if ([item isKindOfClass:[ILPopoverActionItem class]])
    {
        [self.popoverView addAction:(ILPopoverActionItem *)item];
    }
    else
    {
        NSAssert(NO, @"Invalid item passed in");
    }
}

- (void)presentPopoverFromView:(UIView *)view animated:(BOOL)animated
{
    [self.popoverView setBackgroundColor:self.theme.backgroundColor];
    [self.popoverView setCornerRadius:self.theme.cornerRadius];
    [self.popoverView.layer setShadowColor:self.theme.shadowColor.CGColor];
    [self.popoverView.layer setShadowRadius:self.theme.shadowRadius];
    [self.popoverView.layer setShadowOffset:self.theme.shadowOffset];
    [self.popoverView.layer setShadowOpacity:self.theme.shadowOpacity];
    [self.popoverView.arrowView setArrowSize:self.theme.arrowSize];

    [self.applicationWindow addSubview:self];
    
    CGRect popoverFrame = self.popoverView.frame;
    popoverFrame.origin.y = CGRectGetMaxY(view.frame) + 2;

    [self.popoverView setFrame:popoverFrame];
    
    self.view = view;

    [self startAnimatingPopover];

    if (animated)
    {
        [self.popoverView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        
        [UIView animateKeyframesWithDuration:0.6 delay:0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.4 animations:^{
                [self.popoverView setAlpha:1];
            }];
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.3 animations:^{
                [self.popoverView setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
            }];
            [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.3 animations:^{
                [self.popoverView setTransform:CGAffineTransformMakeScale(1, 1)];
            }];
        } completion:nil];
    }
    else
    {
        [self.popoverView setAlpha:1];
    }

}

- (void)dismissPopoverAnimated:(BOOL)animated
{
    [self.popoverView setTransform:CGAffineTransformIdentity];

    if (animated)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect popoverFrame = self.popoverView.frame;
            popoverFrame.origin.y += 100;
            [self.popoverView setFrame:popoverFrame];
            [self.popoverView setAlpha:0];
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else
    {
        [self removeFromSuperview];
    }
}

- (void)startAnimatingPopover
{
    [UIView animateWithDuration:0.7
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect popoverFrame = self.popoverView.frame;
                         popoverFrame.origin.y -= 4;
                         [self.popoverView setFrame:popoverFrame];
                     }
                     completion:nil];
}

@end
