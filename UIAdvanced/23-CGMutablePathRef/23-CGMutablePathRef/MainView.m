//
//  MainView.m
//  23-CGMutablePathRef
//
//  Created by Aixtuz Kang on 15/6/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MainView.h"

@implementation MainView

// 绘制图形
- (void)drawRect:(CGRect)rect {
    //!!!: CGContextRef, CGMutablePathRef 已将*号封装在内;
    
    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 创建路径对象
    CGMutablePathRef pathM = CGPathCreateMutable();
    
    // 添加路径
    CGPathMoveToPoint(pathM, nil, 50, 50);
    CGPathAddLineToPoint(pathM, nil, 100, 100);
    
    // 路径添加到图形上下文
    CGContextAddPath(ctx, pathM);
    
    // 渲染
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // 内存管理
    // CGPathRelease(pathM);
    CFRelease(pathM);
}

@end

