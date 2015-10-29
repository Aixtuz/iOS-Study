//
//  MainView.m
//  24-DrawPicText
//
//  Created by Aixtuz Kang on 15/6/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MainView.h"

@implementation MainView

//!!!: 设置Storyboard中view的class

// 绘制图片
- (void)drawRect:(CGRect)rect {
    
    // 绘制图片
    // 加载要绘制的图片
    UIImage *img = [UIImage imageNamed:@"me"];
    
    //!!!: 渲染方法三选一
    // 从原点开始绘制
    [img drawAtPoint:CGPointZero];
    // 区域填充
    [img drawInRect:rect];
    // 区域平铺
    [img drawAsPatternInRect:rect];
    
    // 绘制文字
    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 创建路径对象,附带矩形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 100, 200, 350)];
    
    // 添加路径到图形上下文中
    CGContextAddPath(ctx, path.CGPath);
    
    // 绘制图形
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // 设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blueColor];
    shadow.shadowOffset = CGSizeMake(10, 10);
    shadow.shadowBlurRadius = 1;
    NSString *msg = @"hello world! hello world! hello world! hello world! hello world! ";
    NSDictionary *attrs = @{
                            NSFontAttributeName : [UIFont systemFontOfSize:15],
                            NSForegroundColorAttributeName : [UIColor redColor],
                            NSUnderlineStyleAttributeName : @(10),
                            NSShadowAttributeName : shadow
                            };
    // 渲染
    [msg drawInRect:CGRectMake(50, 100, 200, 300) withAttributes:attrs];
}

@end

