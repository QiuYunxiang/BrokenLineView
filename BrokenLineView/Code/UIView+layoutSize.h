//
//  UIView+layoutSize.h
//
//  Created by Woz Wong on 15/12/19.
//  Copyright © 2015年 code4Fun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (layoutSize)
@property CGFloat width;
// height
@property CGFloat height;

@property CGFloat x;

@property CGFloat y;

@property CGFloat centerX;

@property CGFloat centerY;

@property CGFloat bottom;

@property CGFloat right;

- (BOOL)wx_intersectsWithAnotherView:(UIView *)view;
@end
