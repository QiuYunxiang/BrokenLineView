//
//  GradientBrokenLineModel.h
//  TCHealth
//
//  Created by 邱云翔 on 2019/8/5.
//  Copyright © 2019 邱云翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientBrokenLineModel : NSObject

/**
 转换后的坐标，view坐标系
 */
@property (nonatomic,assign) CGPoint transformPoint;

/**
 转换后的坐标，坐标轴坐标系
 */
@property (nonatomic,assign) CGPoint axesPoint;

@end

NS_ASSUME_NONNULL_END
