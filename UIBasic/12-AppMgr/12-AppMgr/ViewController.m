//
//  ViewController.m
//  12-AppMgr
//
//  Created by Aixtuz Kang on 15/5/26.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 创建一个AppView
    UIView *appView = [[UIView alloc] init];

    //!!!:  设置归属
    [self.view addSubview:appView];

    // 设置frame
    CGFloat appViewW = 100;
    CGFloat appViewH = 120;
    CGFloat appViewX = 30;
    CGFloat appViewY = 30;
    appView.frame = CGRectMake(appViewX, appViewY, appViewW, appViewH);

    //!!!:  设置背景色
    appView.backgroundColor = [UIColor greenColor];


    // 创建另一个AppView
    UIView *appView01 = [[UIView alloc] init];

    // 设置归属
    [self.view addSubview:appView01];

    // 设置frame
    CGFloat appView01X = appViewX + appViewW + 20;
    CGFloat appView01Y = appViewY;
    appView01.frame = CGRectMake(appView01X, appView01Y, appViewW, appViewH);

    //!!!: 设置背景
    appView01.backgroundColor = [UIColor greenColor];

}

@end

