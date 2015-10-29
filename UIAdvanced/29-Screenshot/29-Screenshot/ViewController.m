//
//  ViewController.m
//  29-Screenshot
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

// 截屏
- (IBAction)screenshot:(id)sender {
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    
    // 回去图形上下文
    //!!!: 不要带*号
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 获取要截取view的layer
    [self.view.layer renderInContext:ctx];
    
    // 从图形上下文中获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    // 保存到相册
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
