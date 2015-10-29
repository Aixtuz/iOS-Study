//
//  ViewController.m
//  19-Storyboard4Modal
//
//  Created by Aixtuz Kang on 15/6/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "PopViewController.h"

@interface ViewController () <PopViewControllerDelegate>

// 按钮属性
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

// 加载完毕,点击跳转.先去完善控制器描述类(代理协议&&属性);
// VC引用头文件,拦截Segue设置title,遵守代理协议,实现代理方法回调参数;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // 获取目标控制器
    UINavigationController *nav = segue.destinationViewController;
    // 栈顶控制器
    PopViewController *pc = (PopViewController *)[nav topViewController];
    
    // 设置title
    pc.navigationItem.title = @"欢迎";
    
    // 设置代理
    pc.delegate = self;
}

// 代理方法
- (void)closePC:(PopViewController *)pc withTitiel:(NSString *)str {
    
    // 设置按钮
    [self.btn setTitle:str forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
