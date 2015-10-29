//
//  ViewController.m
//  25-DrawImageView
//
//  Created by Aixtuz Kang on 15/6/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "KCLImageView.h"

@interface ViewController ()

// 图片框属性
// @property (nonatomic, weak) UIImageView *imageView;
// 自定义View的图片框属性, Storyboard设置self.view为自定义类型
@property (nonatomic, weak) KCLImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 代码创建UIImageView的一般方法
    /*
     // 创建对象
     UIImageView *imageView = [[UIImageView alloc] init];
     // 设置图片
     imageView.image = [UIImage imageNamed:@"me"];
     // 设置frame
     imageView.frame = CGRectMake(100, 100, 100, 100);
     // 添加到视图
     [self.view addSubview:imageView];
     // 属性强指针引用
     self.imageView = imageView;
     */
    
    // 自定义View实现同样功能
    // 创建自定义View对象
    KCLImageView *imgView = [[KCLImageView alloc] init];
    
    // 设置图片
    imgView.image = [UIImage imageNamed:@"me"];
    
    // 设置frame
    imgView.frame = CGRectMake(100, 100, 100, 100);
    
    // 添加到View中
    [self.view addSubview:imgView];
    
    // 属性强指针引用
    //!!!: 换成自定义View后,属性要换成自定义类型的指针
    self.imgView = imgView;
}

// 点击更换图片
- (IBAction)changePic:(UIButton *)sender {
    self.imgView.image = [UIImage imageNamed:@"dst2"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
