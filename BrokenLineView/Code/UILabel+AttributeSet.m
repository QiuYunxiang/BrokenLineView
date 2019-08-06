//
//  UILabel+AttributeSet.m
//  TCHealth
//
//  Created by 邱云翔 on 2019/7/29.
//  Copyright © 2019 邱云翔. All rights reserved.
//

#import "UILabel+AttributeSet.h"

@implementation UILabel (AttributeSet)

#pragma mark 设置公共属性
- (void)setUpCommonAttributeWithText:(NSString *)text textName:(NSString * _Nullable)textName textFont:(CGFloat)textFont textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    self.text = text ? text : @"";
    textName = textName ? textName : @"PingFangSC-Regular";
    self.font = [UIFont fontWithName:textName size:textFont];
    self.textColor = textColor ? textColor : [UIColor blackColor];
    self.textAlignment = textAlignment;
}

@end
