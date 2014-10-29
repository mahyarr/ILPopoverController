//
//  ILPopoverTheme.h
//  ILPopoverController
//
//  Created by Mahyar Raissi on 2014-10-27.
//  Copyright (c) 2014 Mahyar Raissi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ILPopoverTheme : NSObject

@property (nonatomic) CGSize arrowSize;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic) CGFloat shadowRadius;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) CGFloat shadowOpacity;
@property (nonatomic) UIEdgeInsets contentInset;

@end
