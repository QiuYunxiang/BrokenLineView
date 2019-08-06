//
//  GradientBrokenLineView.m
//  ZheXianDemo
//
//  Created by 邱云翔 on 2019/8/5.
//  Copyright © 2019 邱云翔. All rights reserved.
//

#import "GradientBrokenLineView.h"
#import "UILabel+AttributeSet.h"
#import "UIView+layoutSize.h"
#import "GradientBrokenLineModel.h"
#import "Define.h"

@interface GradientBrokenLineView ()

/**
 转换后的point数组
 */
@property (nonatomic,strong) NSMutableArray <GradientBrokenLineModel *>*dataPointArray;

/**
 标题
 */
@property (nonatomic,strong) UILabel *titleLab;

/**
 副标题
 */
@property (nonatomic,strong) UILabel *subTitleLab;

/**
 y轴标题
 */
@property (nonatomic,strong) UILabel *y_TitleLab;

/**
 x轴标题数组
 */
@property (nonatomic,strong) NSMutableArray <UILabel *>*x_TitleLabArray;

/**
 折线图绘制背景图
 */
@property (nonatomic,strong) UIView *brokenLineBackView;

/**
 折线layer
 */
@property (nonatomic,strong) CAShapeLayer *brokenLineLayer;

/**
 渐变色layer
 */
@property (nonatomic,strong) CAGradientLayer *gradientLayer;

/**
 跟随移动的点状View
 */
@property (nonatomic,strong) UIView *pointView;

/**
 竖直直线
 */
@property (nonatomic,strong) UIView *lineView;

/**
 标签View
 */
//@property (nonatomic,strong) UIView *logoView;

@end

@implementation GradientBrokenLineView

- (instancetype)initWithFrame:(CGRect)frame withOriginalArray:(NSArray <NSString *>*)originalArray {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBaseUpViews]; //基础视图
        [self transformPoint:originalArray]; //坐标转换
        [self setUpLineViewOfX]; //画X轴向横线
        [self setUpBrokenLineViews]; //画折线
        [self setUpBrokenLinePointViews]; //画折线上的点view
    }
    return self;
}

#pragma mark 设置基础视图
- (void)setBaseUpViews {
    self.backgroundColor = [UIColor whiteColor];
    //
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidthScale(20), kWidthScale(10), kWidthScale(140), kWidthScale(38))];
    [self.titleLab setUpCommonAttributeWithText:@"标题" textName:@"PingFangSC-Semibold" textFont:18 textColor:COLOR_RGBHEX(0x333333) textAlignment:(NSTextAlignmentLeft)];
    [self addSubview:self.titleLab];
    
    //
    self.subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidthScale(20), self.titleLab.bottom + kWidthScale(5), kWidthScale(40), kWidthScale(18))];
    [self.subTitleLab setUpCommonAttributeWithText:@"副标题" textName:nil textFont:12 textColor:COLOR_RGBHEX(0x333333) textAlignment:(NSTextAlignmentCenter)];
    [self addSubview:self.subTitleLab];
    
    //
    self.brokenLineBackView = [[UIView alloc] initWithFrame:CGRectMake(kWidthScale(56), self.subTitleLab.bottom + kWidthScale(9), kWidthScale(285), kWidthScale(122))];
    self.brokenLineBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.brokenLineBackView];
    
    //
    self.y_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidthScale(20), self.brokenLineBackView.bottom - kWidthScale(9), kWidthScale(32), kWidthScale(20))];
    [self.y_TitleLab setUpCommonAttributeWithText:@"Y轴" textName:nil textFont:12 textColor:COLOR_RGBHEX(0x333333) textAlignment:(NSTextAlignmentCenter)];
    [self addSubview:self.y_TitleLab];
}

#pragma mark 换算坐标
- (void)transformPoint:(NSArray <NSString *>*)originalArray {
    //
    if (!originalArray || originalArray.count == 0) {
        return;
    }
    
    //
    CGFloat height_point = 0;
    for (NSString *heightStr in originalArray) {
        height_point = MAX(height_point, [heightStr floatValue]);
    }
    
    CGFloat width_back = self.brokenLineBackView.width - kWidthScale(5);
    CGFloat height_back = self.brokenLineBackView.height - kWidthScale(2);
    
    //找出最大值,对比height
    height_point = height_point * 1.25;
    CGFloat proportionHeight = height_back / height_point;
    
    //换算坐标
    CGFloat interval_X = width_back;
    if (originalArray.count > 1) {
        interval_X = width_back / (originalArray.count-1);
    }
    
    for (int i = 0; i < originalArray.count; i++) {
        CGFloat x = kWidthScale(2) + interval_X * i;
        CGFloat value = [originalArray[i] floatValue];
        //找出对应的Y坐标
        CGFloat y = value * proportionHeight;
        GradientBrokenLineModel * model = [[GradientBrokenLineModel alloc] init];
        model.transformPoint = CGPointMake(x, height_back - y);
        model.axesPoint = CGPointMake(x, y);
        [self.dataPointArray addObject:model];
    }
}

#pragma mark 折线+渐变布局视图
- (void)setUpBrokenLineViews {
    if (!self.dataPointArray || self.dataPointArray.count == 0) {
        return;
    }
    
    //折线路径
    UIBezierPath *brokenLinePath = [UIBezierPath bezierPath];
    [brokenLinePath moveToPoint:self.dataPointArray[0].transformPoint];
    
    //遮罩路径
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    [maskPath moveToPoint:self.dataPointArray[0].transformPoint];
    
    //绘制折线路径
    for (int i = 1; i < self.dataPointArray.count; i++) {
        CGPoint point = self.dataPointArray[i].transformPoint;
        [maskPath addLineToPoint:point];
        [brokenLinePath addLineToPoint:point];
    }
    
    //绘制遮罩路径
    [maskPath addLineToPoint:CGPointMake(self.brokenLineBackView.right, self.brokenLineBackView.bottom)];
    [maskPath addLineToPoint:CGPointMake(0, self.brokenLineBackView.bottom)];
    [maskPath addLineToPoint:self.dataPointArray[0].transformPoint];
    
    //
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    //
    self.brokenLineLayer.path = brokenLinePath.CGPath;
    maskLayer.path = maskPath.CGPath;
    self.gradientLayer.mask = maskLayer;
    self.gradientLayer.opacity = 0.5;
    
    //
    [self.brokenLineBackView.layer addSublayer:self.brokenLineLayer];
    [self.brokenLineBackView.layer addSublayer:self.gradientLayer];
}

#pragma mark X轴方向上线条
- (void)setUpLineViewOfX {
    CGFloat x = kWidthScale(2);
    CGFloat y = kWidthScale(2);
    CGFloat interval_Y = kWidthScale(120) / 3;
    
    for (int i = 0; i < 4; i++) {
        UIView *lineView = [self lineViewWithColor:i == 3 ? COLOR_RGBHEX(0xC9C9C9) : COLOR_RGBHEX(0xEEEEEE)];
        lineView.frame = CGRectMake(x, y + i * interval_Y - 1, lineView.width, lineView.height);
        [self.brokenLineBackView addSubview:lineView];
    }
}

#pragma mark 绘制点，需要在折线之后
- (void)setUpBrokenLinePointViews {
    for (int i = 1; i < self.dataPointArray.count; i++) {
        CGPoint point = self.dataPointArray[i].transformPoint;
        [self.brokenLineBackView addSubview:[self addPointView:point]];
    }
}

#pragma mark X轴方向上标题布局+赋值
- (void)setUpTitleValueOfX:(NSArray<NSString *>*)titleArray {
    //先移除原有视图
    for (UILabel *lab in self.x_TitleLabArray) {
        [lab removeFromSuperview];
    }
    [self.x_TitleLabArray removeAllObjects];
    
    //
    for (int i = 1; i < titleArray.count; i++) {
        UILabel *lab = [[UILabel alloc] init];
        [lab setUpCommonAttributeWithText:titleArray[i] textName:nil textFont:12 textColor:COLOR_RGBHEX(0x424242) textAlignment:(NSTextAlignmentCenter)];
        CGPoint point = [self.brokenLineBackView convertPoint:self.dataPointArray[i].transformPoint toView:self];
        CGPoint labCenter = CGPointMake(point.x, self.brokenLineBackView.bottom + kWidthScale(8));
        lab.center = labCenter;
        lab.bounds = CGRectMake(0, 0, kWidthScale(30), kWidthScale(30));
        [self.x_TitleLabArray addObject:lab];
        [self addSubview:lab];
    }
}

#pragma mark 添加一个点
- (UIView *)addPointView:(CGPoint)point {
    UIView *pointView = [[UIView alloc] init];
    pointView.center = point;
    pointView.bounds = CGRectMake(0, 0, kWidthScale(6), kWidthScale(6));
    pointView.layer.cornerRadius = kWidthScale(3);
    pointView.backgroundColor = COLOR_RGBHEX(0x0AC4BE);
    return pointView;
}

#pragma mark X轴上添加一条线
- (UIView *)lineViewWithColor:(UIColor *)color {
    UIView *lineView = [[UIView alloc] init];
    lineView.bounds = CGRectMake(0, 0, self.brokenLineBackView.width, 1);
    lineView.backgroundColor = color;
    return lineView;
}

#pragma mark 查找对应斜率设置浮动点
- (CGPoint)calculateTheSlope:(CGPoint)point {
    if (point.x >= self.brokenLineBackView.right - kWidthScale(5) || point.x <= kWidthScale(2)) {
        return CGPointZero;
    }
    //
    for (NSInteger i = self.dataPointArray.count-1; i >= 0; --i) {
        CGPoint pointTemp = self.dataPointArray[i].axesPoint;
        if (pointTemp.x <= point.x && point.x <= self.brokenLineBackView.width - kWidthScale(3)) {
            if (i != self.dataPointArray.count - 1) {
                //计算斜率
                CGPoint pointTemp_2 = self.dataPointArray[i+1].axesPoint;
                CGFloat k = (pointTemp_2.y - pointTemp.y) / (pointTemp_2.x - pointTemp.x);
                //找出y轴偏移
                CGFloat offset_Y = kWidthScale(120) - ((point.x - pointTemp_2.x) * k + pointTemp_2.y);
                return CGPointMake(point.x, offset_Y);
            }
        }
    }
    return CGPointZero;
}


#pragma mark 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dealWithTouches:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dealWithTouches:touches withEvent:event];
}

#pragma mark 触摸事件统一操作
- (void)dealWithTouches:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1) {
        UITouch *touch = touches.allObjects.firstObject;
        if (touch.view == self.brokenLineBackView) {
            CGPoint point = [self calculateTheSlope:[touch locationInView:self.brokenLineBackView]];
            if (CGPointEqualToPoint(point, CGPointZero)) {
                return;
            }
            //移动点
            self.pointView.center = point;
            //移动竖线
            self.lineView.frame = CGRectMake(point.x - self.lineView.width / 2, kWidthScale(4), self.lineView.width, self.lineView.height);
        }
    }
}

//#pragma mark 创建一个线性layer
- (CAShapeLayer *)createLineSharelayer {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.borderWidth = 0;
    lineLayer.strokeColor = COLOR_RGBHEX(0xEEEEEE).CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth = 1;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 50)];
    [path addLineToPoint:CGPointMake(self.brokenLineBackView.width, 50)];
    [path addLineToPoint:CGPointMake(0, 50)];
    lineLayer.path = path.CGPath;
    return lineLayer;
}

#pragma SetterAndGetter
- (NSMutableArray<GradientBrokenLineModel *> *)dataPointArray {
    if (!_dataPointArray) {
        _dataPointArray = [NSMutableArray array];
    }
    return _dataPointArray;
}

- (CAShapeLayer *)brokenLineLayer {
    if (!_brokenLineLayer) {
        _brokenLineLayer = [CAShapeLayer layer];
        _brokenLineLayer.frame = self.brokenLineBackView.bounds;
        _brokenLineLayer.borderWidth = 0;
        _brokenLineLayer.strokeColor = COLOR_RGBHEX(0x0AC4BE).CGColor;
        _brokenLineLayer.fillColor = [UIColor clearColor].CGColor;
        _brokenLineLayer.lineCap = @"round";
        _brokenLineLayer.lineJoin = @"round";
        _brokenLineLayer.lineWidth = 1;
    }
    return _brokenLineLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.brokenLineBackView.bounds;
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0, 1);
        _gradientLayer.colors = @[(__bridge id)COLOR_RGBHEX(0x0AC4BE).CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    }
    return _gradientLayer;
}

- (UIView *)pointView {
    if (!_pointView) {
        _pointView = [self addPointView:CGPointZero];
        [self.brokenLineBackView addSubview:_pointView];
    }
    return _pointView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = COLOR_RGBHEX(0x0AC4BE);
        _lineView.bounds = CGRectMake(0, 0, 1, kWidthScale(118));
        [self.brokenLineBackView addSubview:_lineView];
    }
    return _lineView;
}

- (void)setTitleStr:(NSString *)titleStr {
    self.titleLab.text = titleStr;
}

- (void)setSubTitleStr:(NSString *)subTitleStr {
    self.subTitleLab.text = subTitleStr;
}

- (void)setY_titleStr:(NSString *)y_titleStr {
    self.y_TitleLab.text = y_titleStr;
}

//- (UIView *)logoView {
//    if (!_logoView) {
//        _logoView = [[UIView alloc] init];
//        _logoView.bounds = CGRectMake(0, 0, kWidthScale(<#value#>), <#CGFloat height#>)
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
