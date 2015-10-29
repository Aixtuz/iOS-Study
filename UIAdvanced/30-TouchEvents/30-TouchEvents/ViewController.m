//
//  ViewController.m
//  30-TouchEvents
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

//!!!: 切换self.view的类,查看自定义view的触摸事件

// 手指按下
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"==========TouchesBegan==========");
    // touches集合中存储触“触摸对象”
    // 获取一个触摸对象
    UITouch *touch = touches.anyObject;
    // 打印触摸对象的个数,连击次数;
    NSLog(@"%@", @(touch.tapCount));
    
    // 获取当前触摸的View
    NSLog(@"%@", touch.view);
    
    // 获取坐标
    CGPoint loc = [touch locationInView:touch.view];
    CGPoint pre = [touch previousLocationInView:touch.view];
    NSLog(@"now is %@", NSStringFromCGPoint(pre));
    NSLog(@"pre is %@", NSStringFromCGPoint(loc));
    NSLog(@"==========TouchesBegan==========");
}

// 手指拖动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"==========TouchesMoved==========");
    // touches集合中存储触“触摸对象”
    // 获取一个触摸对象
    UITouch *touch = touches.anyObject;
    // 打印触摸对象的个数,连击次数;
    NSLog(@"%@", @(touch.tapCount));
    
    // 获取当前触摸的View
    NSLog(@"%@", touch.view);
    
    // 获取坐标
    CGPoint loc = [touch locationInView:touch.view];
    CGPoint pre = [touch previousLocationInView:touch.view];
    NSLog(@"now is %@", NSStringFromCGPoint(pre));
    NSLog(@"pre is %@", NSStringFromCGPoint(loc));
    NSLog(@"==========TouchesMoved==========");
}

// 手指抬起
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"TouchesEnded");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
