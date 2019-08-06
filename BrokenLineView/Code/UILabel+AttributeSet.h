//
//  UILabel+AttributeSet.h
//  TCHealth
//
//  Created by 邱云翔 on 2019/7/29.
//  Copyright © 2019 邱云翔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AttributeSet)

/**
 设置公共属性

 @param text 文本
 @param textName 字体种类
 @param textFont 大小
 @param textColor 颜色
 @param textAlignment 对齐方式
 */
- (void)setUpCommonAttributeWithText:(NSString *)text textName:(NSString * _Nullable )textName textFont:(CGFloat)textFont textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
