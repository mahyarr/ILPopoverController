//
//  ILPopoverItem.h
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-26.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ILPopoverItemAlignment) {
    ILPopoverItemAlignmentLeft,
    ILPopoverItemAlignmentCenter,
    ILPopoverItemAlignmentRight
};

@interface ILPopoverItem : NSObject

@property (nonatomic) ILPopoverItemAlignment alignment;
@property (nonatomic) UIEdgeInsets inset;
@property (nonatomic) CGSize size;

@end
