//
//  UIView+layoutSize.m
//
//  Created by Woz Wong on 15/12/19.
//  Copyright © 2015年 code4Fun. All rights reserved.
//

#import "UIView+layoutSize.h"

@implementation UIView (layoutSize)

- (BOOL)wx_intersectsWithAnotherView:(UIView *)view
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }

    CGRect selfRect = [self convertRect:self.bounds toView:nil];//nil默认就是window
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;

}

- (CGFloat)x
{
    return self.frame.origin.x;

}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}


- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)bottom
{
    return self.y + self.height;
}

- (CGFloat)right
{
    return self.x + self.width;
}


@end
