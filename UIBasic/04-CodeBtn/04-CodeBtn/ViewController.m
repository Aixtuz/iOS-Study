//
//  ViewController.m
//  04-CodeBtn
//
//  Created by Aixtuz Kang on 15/5/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1. 创建按钮对象
    UIButton *photo = [[UIButton alloc] init];
    
    //!!!: 2. 设置控件归属
    [self.view addSubview:photo];
    
    //!!!: 3.设置位置
    photo.frame = CGRectMake(16, 20, 100, 100);
    
    //!!!: 4. 设置背景图片
    // 4.1. 设置普通状态的图片
    UIImage *headNormal = [UIImage imageNamed:@"btn_01"];
    [photo setBackgroundImage:headNormal forState:UIControlStateNormal];
    
    // 4.2. 设置高亮状态的图片
    UIImage *headHighlighted = [UIImage imageNamed:@"btn_02"];
    [photo setBackgroundImage:headHighlighted forState:UIControlStateHighlighted];
    
    //!!!: 5. 设置文字
    // 5.1. 设置普通文字
    [photo setTitle:@"点我试试？" forState:UIControlStateNormal];
    
    // 5.2. 设置高亮文字
    [photo setTitle:@"我闪！" forState:UIControlStateHighlighted];
    
    //!!!: 6. 设置文字的颜色
    // 6.1. 设置普通文字颜色
    UIColor *colorNormal = [UIColor redColor];
    [photo setTitleColor:colorNormal forState:UIControlStateNormal];
    
    // 6.2. 设置高亮文字颜色
    UIColor *colorHighlighted = [UIColor greenColor];
    [photo setTitleColor:colorHighlighted forState:UIControlStateHighlighted];
    
    //!!!: 7. 监听按钮的点击方法
    /*
     addTarget:表示监听器 :
     forControlEvents:监听到得事件
     action:监听到按钮点击后要做的事情
     */
    [photo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //!!!: 8. 添加系统默认类型按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:addBtn];
    addBtn.frame = CGRectMake(150, 150, 35, 35);
    
    //!!!: 9. 监听多个按钮点击
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

// 监听按钮
- (void)btnClick:(id)sender{

    NSLog(@"%@", sender);
    
}

//!!!: 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    
    return YES;
    
}

@end

