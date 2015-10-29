//
//  DefaultViewController.m
//  18-Modal4Controller
//
//  Created by Aixtuz Kang on 15/6/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "DefaultViewController.h"
#import "PopViewController.h"

@interface DefaultViewController () <PopViewControllerDelegate>

@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// 点击Modal弹出控制器
- (IBAction)btnClick:(UIButton *)sender {
    
    // 创建pop控制器
    PopViewController *pc = [[PopViewController alloc] init];
    
    // 设置DC遵守协议作PC代理,用于谁Modal谁关闭,PC中定义代理属性及协议;
    pc.delegate = self;
    
    // 创建导航控制器附带pc
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pc];
    
    // Modal弹出控制器
    [self presentViewController:nav animated:YES completion:nil];
}

// 关闭Modal的代理(谁打开谁关闭)
- (void)pcDidCloseBtn:(PopViewController *)pc {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
