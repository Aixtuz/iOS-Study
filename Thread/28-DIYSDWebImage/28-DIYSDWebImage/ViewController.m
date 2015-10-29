//
//  ViewController.m
//  28-DIYSDWebImage
//
//  Created by Aixtuz Kang on 15/7/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 创建视图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 250, 300)];
    // 背景色
    imageView.backgroundColor = [UIColor cyanColor];
    // 设置归属
    [self.view addSubview:imageView];
    
    // 图片地址
    NSString *urlStr = @"http://b.hiphotos.baidu.com/image/h%3D360/sign=43d2e51dd13f8794ccff4e28e21a0ead/728da9773912b31b61c6cb8c8318367adbb4e1e9.jpg";
    
    // UIImageView 分类增加下载图片的方法
    [imageView setImageWithUrlString:urlStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
