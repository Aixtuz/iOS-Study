//
//  KCLViewController.m
//  06-Code4Controller
//
//  Created by Aixtuz Kang on 15/6/21.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "KCLViewController.h"

@interface KCLViewController ()

@end

@implementation KCLViewController

- (void)addBtn {
    // 获取主窗口
    // UIWindow *main = [UIApplication  sharedApplication].windows[0];
    UIWindow *main = [UIApplication sharedApplication].keyWindow;
    
    // 测试数据
    // NSLog(@"%@", main);
    // NSLog(@"%@", @([UIApplication sharedApplication].windows.count));
    
    // 主窗口添加按钮
    UIButton *btn =[[UIButton alloc] init];
    [btn setTitle:@"一个按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [main addSubview:btn];
}

//!!!: 启动过程: Step 02 - View Load完毕;
- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景色
    self.view.backgroundColor = [UIColor cyanColor];
    
    // [self addBtn];
    //!!!: 此时didFinishLaunching还没结束,window还没显示;
    
}

//!!!: 启动过程: Step 02 - View 即将显示;
- (void)viewWillAppear:(BOOL)animated
{
    // [self addBtn];
}

//!!!: 启动过程: Step 02 - View 显示完毕;
//!!!: 此时View加载完毕,添加按钮才能看到;
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self addBtn];
}

@end
