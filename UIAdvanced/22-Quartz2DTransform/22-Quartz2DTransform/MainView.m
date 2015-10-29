//
//  MainView.m
//  22-Quartz2DTransform
//
//  Created by Aixtuz Kang on 15/6/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MainView.h"

@implementation MainView

//!!!: 重写drawRect,却不执行,检查Storyboard中,要绘制的UIView是否设置为当前类;
- (void)drawRect:(CGRect)rect {
    
    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 绘图前保存当前状态
    CGContextSaveGState(ctx);
    
    //!!!: 形变设置
    // 缩放: 坐标不变,长宽缩放
    CGContextScaleCTM(ctx, 0.5, 0.5);
    
    // 平移: 坐标移动
    CGContextTranslateCTM(ctx, 200, 200);
    
    // 旋转: 相对原点旋转
    CGContextRotateCTM(ctx, M_PI_4 * 0.5);
    
    // 创建路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 添加路径
    // 线
    [path moveToPoint:CGPointMake(150, 150)];
    [path addLineToPoint:CGPointMake(180, 450)];
    // 圆
    UIBezierPath *path1 =[UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    // 矩形
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(50, 300, 180, 80)];
    
    // 路径对象添加到图形上下文
    CGContextAddPath(ctx, path.CGPath);
    CGContextAddPath(ctx, path1.CGPath);
    CGContextAddPath(ctx, path2.CGPath);
    
    // 设置状态
    // 颜色
    [[UIColor cyanColor] set];
    // 线宽
    CGContextSetLineWidth(ctx, 5);
    // 线段连接点
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    // 渲染
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //!!!: 形变是一种属性状态, 和颜色,线宽一样, 修改后只影响后续使用;
    // 取出保存的初始状态
    CGContextRestoreGState(ctx);
    
    // 绘制新图形
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 50, 50)];
    CGContextAddPath(ctx, path3.CGPath);
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end
