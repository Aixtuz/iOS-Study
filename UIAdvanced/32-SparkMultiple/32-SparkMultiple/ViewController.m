//
//  ViewController.m
//  32-SparkMultiple
//
//  Created by Aixtuz Kang on 15/6/30.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 用于存储图片数据
@property (nonatomic, strong) NSArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


// 懒加载
- (NSArray *)images {
    if (_images == nil) {
        _images = @[
                    [UIImage imageNamed:@"spark_blue"],
                    [UIImage imageNamed:@"spark_cyan"],
                    [UIImage imageNamed:@"spark_green"],
                    [UIImage imageNamed:@"spark_magenta"],
                    [UIImage imageNamed:@"spark_red"],
                    [UIImage imageNamed:@"spark_yellow"]
                    ];
    }
    return _images;
}

//!!!: 控件属性中勾选: Multiple,开启多点触摸
// 触摸事件(一点一个点)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        // 获取当前触摸点
        CGPoint loc = [touch locationInView:self.view];
        
        // 取图片创建图片框
        UIImageView *imgView = [[UIImageView alloc] initWithImage:self.images[arc4random() % 6]];
        
        // 设置位置并添加
        imgView.center = loc;
        [self.view addSubview:imgView];
        
        // 延迟消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 动画至透明
            [UIView animateWithDuration:0.5 animations:^{
                imgView.alpha = 0;
            } completion:^(BOOL finished) {
                [imgView removeFromSuperview];
            }];
        });
    }
}

// 拖动事件(一拖一条线)
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        // 获取当前触摸点
        CGPoint loc = [touch locationInView:self.view];
        
        // 取图片创建图片框
        UIImageView *imgView = [[UIImageView alloc] initWithImage:self.images[arc4random() % 6]];
        
        // 设置位置并添加
        imgView.center = loc;
        [self.view addSubview:imgView];
        
        // 延迟消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 动画至透明
            [UIView animateWithDuration:0.5 animations:^{
                imgView.alpha = 0;
            } completion:^(BOOL finished) {
                [imgView removeFromSuperview];
            }];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
