
//
//  BasicView.m
//  20-Quartz2DBasic
//
//  Created by Aixtuz Kang on 15/6/26.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "BasicView.h"

@implementation BasicView

// 重写drawRect方法,实现UIView上绘图
- (void)drawRect:(CGRect)rect {
    
    //!!!: 使用Quartz2D 原生API绘图
    /*
     // 获取图形上下文
     //!!!: 注意CGContextRef内部已经封装了*号
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     // 绘制路径
     // 设置起点
     CGContextMoveToPoint(ctx, 30, 30);
     
     // 增加线段
     CGContextAddLineToPoint(ctx, 100, 100);
     CGContextAddLineToPoint(ctx, 30, 180);
     
     // 关闭路径
     CGContextClosePath(ctx);
     
     // 设置新起点
     CGContextMoveToPoint(ctx, 30, 30);
     // 增加线段
     CGContextAddLineToPoint(ctx, 100, 30);
    
     // 渲染
     CGContextFillPath(ctx);
     */
    
    //!!!: 使用UIBezierPath路径对象绘图
    /*
     // 获取图形上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     // 创建路径对象UIBezierPath
     UIBezierPath *path =[UIBezierPath bezierPath];
     
     // 想路径对象中添加路径
     [path moveToPoint:CGPointMake(30, 30)];
     [path addLineToPoint:CGPointMake(100, 100)];
     [path addLineToPoint:CGPointMake(30, 180)];
     // 关闭路径
     [path closePath];
     
     [path moveToPoint:CGPointMake(50, 200)];
     [path addLineToPoint:CGPointMake(200, 200)];
     
     // 把路径对象添加到图形上下文中
     //!!!: UIBezierPath 转 CGPath,再添加到图形上下文中
     CGContextAddPath(ctx, path.CGPath);
     
     // 渲染(把上下文中的路径渲染到设备上)
     // 描绘路径
     // CGContextStrokePath(ctx);
     // CGContextDrawPath(ctx, kCGPathStroke);
     
     // 填充区域
     // CGContextFillPath(ctx);
     CGContextDrawPath(ctx, kCGPathFill);
     */
    
    // 绘制矩形
    /*
     // 获取图片上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     // 一步完成创建路径对象&&添加路径
     UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 50, 160, 100)];
     
     // 把路径对象添加到图形上下文中
     //!!!: 添加图形上下文的路径需要转成CGPath
     CGContextAddPath(ctx, path.CGPath);
     
     // 渲染
     // CGContextStrokePath(ctx);
     CGContextDrawPath(ctx, kCGPathStroke);
     */
    
    // 绘制圆角矩形
    /*
     // 获取图片上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     // 一步完成创建路径对象&&添加路径
     UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 50, 160, 100) cornerRadius:20];
     
     // 把路径对象添加到图形上下文中
     CGContextAddPath(ctx, path.CGPath);
     
     // 渲染
     CGContextDrawPath(ctx, kCGPathStroke);
     */
    
    // 绘制椭圆
    /*
     // 获取图片上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     // 一步完成创建路径对象&&添加路径
     // 宽高决定添加;
     UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 50, 160, 100)];
     
     // 把路径对象添加到图片上下文
     CGContextAddPath(ctx, path.CGPath);
     
     // 渲染
     CGContextDrawPath(ctx, kCGPathStroke);
     */
    
    // 绘制弧线
    /*
     // 获取图形上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     // 根据圆心,半径,弧线端点,创建UIBezierPath对象
     //!!!: CG位置尺寸,不要带*号
     // 圆心
     CGPoint centerP = CGPointMake(100, 100);
     // 半径
     CGFloat radius = 100;
     // 端点(度数,不要以变量理解,要视为刻度)
     CGFloat start = 0;
     CGFloat end = -M_PI_4;
     // 创建路径对象, clockwise,YES:顺时针,NO:逆时针
     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:start endAngle:end clockwise:NO];
     
     // 把路径对象添加到图形上下文中
     CGContextAddPath(ctx, path.CGPath);
     
     // 渲染
     CGContextDrawPath(ctx, kCGPathStroke);
    */
    
    //!!!: 设置状态信息
    /*
     // 获取图片上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     // 一步完成创建路径对象&&添加路径
     UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 50, 160, 100)];
     
     // 把路径对象添加到图形上下文中
     CGContextAddPath(ctx, path.CGPath);
     
     // 设置线宽
     CGContextSetLineWidth(ctx, 10);
     
     // 设置线头样式
     CGContextSetLineCap(ctx, kCGLineCapRound);
     
     // 线段连接样式
     CGContextSetLineJoin(ctx, kCGLineJoinRound);
     
     // 设置绘图颜色
     [[UIColor whiteColor] setStroke];
     [[UIColor cyanColor] setFill];
     
     // 渲染
     CGContextDrawPath(ctx, kCGPathFillStroke);
     */
    
    // EOFill奇偶填充
    /*
     // 获取图片上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     // 一步完成创建路径对象&&添加路径
     UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:CGRectMake(20, 50, 160, 100)];
     UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:80 startAngle:0 endAngle:M_PI * 2 clockwise:1];
     
     UIBezierPath *path3 = [UIBezierPath bezierPathWithRect:CGRectMake(100, 10, 50, 180)];
     
     // 把路径添加到图形上下文中
     CGContextAddPath(ctx, path1.CGPath);
     CGContextAddPath(ctx, path2.CGPath);
     CGContextAddPath(ctx, path3.CGPath);
     
     // 渲染: 覆盖奇数次的填充,偶数不填充;
     CGContextDrawPath(ctx, kCGPathEOFill);
     */
    
    // 默认覆盖填充规则
    // 获取图片上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 一步完成创建路径对象&&添加路径
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:1];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:0];
    
    // 把路径添加到图形上下文中
    CGContextAddPath(ctx, path1.CGPath);
    CGContextAddPath(ctx, path2.CGPath);
    
    // 非0绕数规则: 左->右:+1, 左<-右:-1,非零填充;
    CGContextDrawPath(ctx, kCGPathFill);
}

@end
