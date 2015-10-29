//
//  ViewController.m
//  28-WaterMark
//
//  Created by Aixtuz Kang on 15/6/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 点击添加水印
- (IBAction)waterMark:(UIButton *)sender {
    
    // 加载原始图片
    UIImage *img = [UIImage imageNamed:@"dst2"];
    
    // 创建图片大小的图形上下文
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    
    // 绘制图片
    [img drawAtPoint:CGPointZero];
    
    //!!!: 添加水印文字&&图片
    // 绘制文字水印
    NSString *str = @"水水更健康";
    //!!!: 字典内部,逗号间隔,不要用分号.
    NSDictionary *attrs = @{
                            NSFontAttributeName : [UIFont systemFontOfSize:18],
                            NSForegroundColorAttributeName : [UIColor cyanColor]
                            };
    // 根据字典参数绘制到指定point
    [str drawAtPoint:CGPointMake(30, 50) withAttributes:attrs];
    
    // 绘制图片水印
    // 加载水印logo
    UIImage *logo = [UIImage imageNamed:@"logo"];
    
    // 设置水印位置
    CGFloat margin = 50;
    CGFloat x = img.size.width - margin - logo.size.width;
    CGFloat y = img.size.height - margin - logo.size.height;
    
    // 绘制
    [logo drawAtPoint:CGPointMake(x, y)];

    // 图形上下文获取图片
    UIImage *imgMark = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    // 保存图片到相册
    UIImageWriteToSavedPhotosAlbum(imgMark, nil, nil, nil);
    NSLog(@"Save Done");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
