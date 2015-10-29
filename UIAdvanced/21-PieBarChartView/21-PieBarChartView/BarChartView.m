//
//  BarChartView.m
//  21-PieBarChartView
//
//  Created by Aixtuz Kang on 15/6/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "BarChartView.h"

@implementation BarChartView

// 绘制图形
- (void)drawRect:(CGRect)rect {
    
    // 数据
    NSArray *data = @[@300, @150.64, @55.3, @507.7, @95.8, @700, @650.65];
    
    // 获取图形上下文
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    
    // 根据柱形个数计算合适宽度
    CGFloat w = rect.size.width / (data.count * 2 - 1);
    
    // 遍历绘制柱形
    for (int i = 0; i < data.count; i++) {
        
        // 柱形高度
        CGFloat h = rect.size.height * ([data[i] doubleValue] / 1000);
        
        // 坐标
        CGFloat x = w * 2 * i;
        CGFloat y = rect.size.height - h;
        
        // 创建路径对象
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        // 路径对象添加至图形上下文
        CGContextAddPath(ctx, path.CGPath);
        
        // 随机颜色
        [[self colorRandom] set];
        
        // 渲染
        CGContextDrawPath(ctx, kCGPathFill);
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

