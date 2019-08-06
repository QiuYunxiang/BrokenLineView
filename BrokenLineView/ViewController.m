//
//  ViewController.m
//  BrokenLineView
//
//  Created by 邱云翔 on 2019/8/6.
//  Copyright © 2019 邱云翔. All rights reserved.
//

#import "ViewController.h"
#import "GradientBrokenLineView.h"
#import "Define.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //需要给足高度
    GradientBrokenLineView *view = [[GradientBrokenLineView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, kWidthScale(220)) withOriginalArray:@[@"100",@"66",@"155",@"50",@"110",@"90.6",@"140",@"49"]];
    [view setUpTitleValueOfX:@[@"100",@"66",@"155",@"50",@"110",@"90.6",@"140",@"49"]];
    [self.view addSubview:view];
    
}


@end
