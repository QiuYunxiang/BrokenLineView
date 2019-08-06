//
//  Define.h
//  BrokenLineView
//
//  Created by 邱云翔 on 2019/8/6.
//  Copyright © 2019 邱云翔. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define W_IDTH [UIScreen mainScreen].bounds.size.width
#define kWidthScale(value) floor(value*W_IDTH/375.0)//根据iPhone 8尺寸计算宽度比例,
#define COLOR_RGBHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#endif /* Define_h */
