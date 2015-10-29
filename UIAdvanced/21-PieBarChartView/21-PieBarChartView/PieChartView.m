//
//  PieChartView.m
//  21-PieBarChartView
//
//  Created by Aixtuz Kang on 15/6/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "PieChartView.h"

@implementation PieChartView


// 绘图方法
- (void)drawRect:(CGRect)rect {
    
    // 数据
    NSArray *data = @[@30, @15, @5, @17, @3 ,@10, @20];
    
    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 圆心
    CGPoint centerP = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    // 半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5;
    // 端点
    CGFloat start = 0;
    CGFloat end = 0;
    
    // 遍历绘制扇形
    for (int i = 0; i < data.count; i++) {
        
        // 绘制下一个前,更新起点 = 上一个终点 = 上一个起点 + 扇形
        end = M_PI * 2 * ([data[i] doubleValue] / 100) + start;
        
        // 根据圆心,半径,端点,绘制弧线路径对象
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:start endAngle:end clockwise:YES];
        
        // 添加与圆心连线
        [path addLineToPoint:centerP];
        
        // 路径对象添加至图形上下文
        CGContextAddPath(ctx, path.CGPath);
        
        // 随机颜色
        [[self colorRandom] set];
        
        // 渲染
        CGContextDrawPath(ctx, kCGPathFill);
        
        // 设置下次起点为此次终点
        start = end;
    }
}

// 随机颜色
- (UIColor *)colorRandom {
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    return color;
}

// 触摸重新渲染颜色
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
}

@end

