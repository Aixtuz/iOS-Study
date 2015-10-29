//
//  ProgressView.m
//  21-PieBarChartView
//
//  Created by Aixtuz Kang on 15/6/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ProgressView.h"
//!!!: 本Demo饼状图时,slider不可用;

@interface ProgressView ()

// 进度显示
@property (nonatomic, strong) UILabel *labelProgress;

@end

@implementation ProgressView

// 懒加载
- (UILabel *)labelProgress {
    if (_labelProgress == nil) {
        // 创建UILabel
        _labelProgress = [[UILabel alloc] init];
        
        // 设置样式
        _labelProgress.textColor = [UIColor whiteColor];
        _labelProgress.textAlignment = NSTextAlignmentCenter;
        _labelProgress.font = [UIFont systemFontOfSize:20];

        // 添加到ProgressView
        [self addSubview:_labelProgress];
    }
    return _labelProgress;
}

// 布局子控件方法(label)
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 定义frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    self.labelProgress.frame = CGRectMake(x, y, w, h);
}

// 绘制方法
- (void)drawRect:(CGRect)rect {
    
    // 获取图形上下文
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    
    // 根据圆心,半径,创建路径对象
    // 圆心
    CGPoint centerP = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    // 半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5;
    // 创建路径对象, 弧线
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:-M_PI_2 endAngle:M_PI * 2 * self.progress - M_PI_2 clockwise:YES];
    // 弧线连圆心
    [path addLineToPoint:centerP];
    // 闭合
    [path closePath];
    
    // 设置样式
    CGContextSetLineWidth(ctx, 0);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    [[UIColor cyanColor] set];
    
    // 路径对象加入图形上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 渲染
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

// 重写progress的setter方法
- (void)setProgress:(CGFloat)progress {
    
    // 先赋值属性
    _progress = progress;
    
    // 更新label文字
    //!!!: %%转义符
    self.labelProgress.text = [NSString stringWithFormat:@"%0.2f%%", self.progress * 100];
    
    // 重绘
    [self setNeedsDisplay];
}


@end
