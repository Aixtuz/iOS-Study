//
//  MiniView.m
//  31-UIViewFollow
//
//  Created by Aixtuz Kang on 15/6/30.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MiniView.h"

@implementation MiniView

// 触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取当前触摸对象
    UITouch *touch = touches.anyObject;
    
    // 获取当前触摸点
    CGPoint loc = [touch locationInView:self];
    
    // 设置miniView中心点
    self.center = loc;
}

//拖动事件
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取当前触摸对象
    UITouch *touch = touches.anyObject;
    // 获取当前触摸点
    CGPoint loc = [touch locationInView:self];
    // 获取之前触摸点
    CGPoint pre = [touch previousLocationInView:self];
    
    // 计算两点偏移
    CGFloat offsetX = loc.x - pre.x;
    CGFloat offsetY = loc.y - pre.y;
    
    // 设置miniView中心点
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
}

@end
