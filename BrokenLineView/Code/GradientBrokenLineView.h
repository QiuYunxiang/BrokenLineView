//
//  GradientBrokenLineView.h
//  ZheXianDemo
//
//  Created by 邱云翔 on 2019/8/5.
//  Copyright © 2019 邱云翔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientBrokenLineView : UIView

/**
 标题
 */
@property (nonatomic,copy) NSString *titleStr;

/**
 副标题
 */
@property (nonatomic,copy) NSString *subTitleStr;

/**
 y轴底部标题
 */
@property (nonatomic,copy) NSString *y_titleStr;

/**
 指定初始化方法

 @param frame frame
 @param originalArray 原始点数组
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withOriginalArray:(NSArray <NSString *>*)originalArray;

/**
 X轴标题

 @param titleArray 标题数组
 */
- (void)setUpTitleValueOfX:(NSArray<NSString *>*)titleArray;

@end

NS_ASSUME_NONNULL_END
