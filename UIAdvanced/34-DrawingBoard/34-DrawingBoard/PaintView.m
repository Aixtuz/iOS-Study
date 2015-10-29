//
//  PaintView.m
//  34-DrawingBoard
//
//  Created by Aixtuz Kang on 15/7/1.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "PaintView.h"
#import "PaintPath.h"

@interface PaintView ()

// 以数组存储多路径对象
@property (nonatomic, strong) NSMutableArray *paths;

@end

@implementation PaintView

// 清空
- (void)clearScreen {
    // 清空路径
    [self.paths removeAllObjects];
    // 调用重绘
    [self setNeedsDisplay];
}

// 后退
- (void)backward {
    // 删除最近添加
    [self.paths removeLastObject];
    // 调用重绘
    [self setNeedsDisplay];
}

// 橡皮
- (void)erase {
    // 设置背景色
    self.lineColor = self.backgroundColor;
    // 调用重绘
    [self setNeedsDisplay];
}

// 懒加载
- (NSMutableArray *)paths {
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

// 手指按下
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 获取当前触摸对象
    UITouch *touch = touches.anyObject;
    
    // 获取当前触摸点
    CGPoint loc = [touch locationInView:touch.view];
    
    // 创建路径对象
    PaintPath *path = [[PaintPath alloc] init];
    
    // 设置线宽
    path.lineWidth = self.lineWidth;
    
    // 设置颜色
    path.pathLineColor = self.lineColor;
    
    // 设置起点
    [path moveToPoint:loc];
    
    // 存储路径
    [self.paths addObject:path];
}

// 手指移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 获取当前触摸对象
    UITouch *touch = touches.anyObject;
    
    // 获取触摸点
    CGPoint loc = [touch locationInView:touch.view];
    
    // 数组末尾是最新加入的路径
    [[self.paths lastObject] addLineToPoint:loc];
    
    // 调用重绘
    [self setNeedsDisplay];
}

// 绘制图形
- (void)drawRect:(CGRect)rect {
    
    // 遍历渲染路径
    for (PaintPath *path in self.paths) {
        
        if (path.image) {
            [path.image drawAtPoint:CGPointZero];
        } else {
            
            // 设置样式
            path.lineCapStyle = kCGLineCapRound;
            path.lineJoinStyle = kCGLineJoinRound;
            
            // 设置全体路径颜色
            // [self.lineColor set];
            
            // 每次渲染各自路径的颜色(自定义path)
            [path.pathLineColor set];
            
            // 渲染
            [path stroke];
        }
    }
}

// 重写setter方法
- (void)setPhoto:(UIImage *)photo {
    
    // 先赋予自身属性,以便getter取值一致
    _photo = photo;
    
    // photo绘制到paintView上
    // 创建路径对象
    PaintPath *path = [[PaintPath alloc] init];
    
    // 为path的image属性赋值
    path.image = photo;
    
    // 添加路径
    [self.paths addObject:path];
    
    // 重绘
    [self setNeedsDisplay];
}

@end

