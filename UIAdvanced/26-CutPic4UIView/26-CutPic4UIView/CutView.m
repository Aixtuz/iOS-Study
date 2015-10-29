//
//  CutView.m
//  26-CutPic4UIView
//
//  Created by Aixtuz Kang on 15/6/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "CutView.h"

@implementation CutView

// 绘图方法: rect,自定义View的bounds
- (void)drawRect:(CGRect)rect {
    
    //!!!: 图形剪裁显示到自定义UIView上
    //!!!: 获取图形上下文,已经封装*号！
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 在图形上下文中绘制剪裁图形:圆
    // 创建圆形路径(OvaInRect,矩形内切椭圆;)
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    // 添加路径至图形上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 剪裁上下文
    CGContextClip(ctx);
    
    // 图片绘制到上下文
    UIImage *img = [UIImage imageNamed:@"me"];
    [img drawAtPoint:CGPointZero];
}


@end
