//
//  ViewController.m
//  31-UIViewFollow
//
//  Created by Aixtuz Kang on 15/6/29.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 小View
@property (weak, nonatomic) IBOutlet UIView *miniView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//!!!: 封装于: MiniView
// 触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取当前触摸对象
    UITouch *touch = touches.anyObject;
    
    // 获取当前触摸点
    CGPoint loc = [touch locationInView:self.view];
    
    // 设置miniView中心点
    self.miniView.center = loc;
}

//拖动事件
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取当前触摸对象
    UITouch *touch = touches.anyObject;
    // 获取当前触摸点
    CGPoint loc = [touch locationInView:self.view];
    // 获取之前触摸点
    CGPoint pre = [touch previousLocationInView:self.view];
    
    // 计算两点偏移
    CGFloat offsetX = loc.x - pre.x;
    CGFloat offsetY = loc.y - pre.y;
    
    // 设置miniView中心点
    self.miniView.center = CGPointMake(self.miniView.center.x + offsetX, self.miniView.center.y + offsetY);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

