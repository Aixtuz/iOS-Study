//
//  UnlockView.m
//  35-GestureUnlock
//
//  Created by Aixtuz Kang on 15/7/5.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "UnlockView.h"

@interface UnlockView ()

// 保存9按钮
@property (nonatomic, strong) NSArray *buttons;

// 保存选中的按钮
@property (nonatomic, strong) NSMutableArray *selectedBtns;

// 线条颜色
@property (nonatomic, strong) UIColor *lineColor;

// 记录当前点
@property (nonatomic, assign) CGPoint currentP;

@end

@implementation UnlockView

// 懒加载9按钮
- (NSArray *)buttons {
    
    // 为空才加载
    if (_buttons == nil) {
        
        // 创建可变数组存储格子
        NSMutableArray *arrayM = [NSMutableArray array];
        
        // 遍历设置按钮
        for (int i = 0; i < 9; i++) {
            
            // 创建
            UIButton *btn = [[UIButton alloc] init];
            // 设置tag
            btn.tag = i;
            // 禁止交互
            btn.userInteractionEnabled = NO;
            
            // 普通
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            // 高亮
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            // 禁用
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
            
            // UnlockView中添加控件
            [self addSubview:btn];
            
            // 数组汇总
            [arrayM addObject:btn];
        }
        _buttons = arrayM;
    }
    return _buttons;
}

// 布局子控件
- (void)layoutSubviews {
    
    // 父级布局完毕,自身显示,才能布局子控件
    [super layoutSubviews];
    
    // 图片尺寸74x74
    CGFloat w = 74;
    CGFloat h = 74;
    
    //定义列数和间距
    int cols = 3;
    CGFloat marginX = (self.bounds.size.width - w * cols) / (cols - 1);
    CGFloat marginY = marginX;
    
    // 循环定位
    for (int i = 0; i < self.buttons.count; i++) {

        // 行
        CGFloat row = i / cols;
        // 列
        CGFloat col = i % cols;
        
        // x
        CGFloat x = (w + marginX) * col;
        
        // y
        CGFloat y = (h + marginY) * row;
        
        UIButton *btn = self.buttons[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
}

- (void)touchesBtnWithLoc:(CGPoint)loc {
    
    // 判断触控范围归属,设置该按钮selected;
    for (UIButton *btn in self.buttons) {
        
        // Rect包含Point,btn当前未被选中
        if (CGRectContainsPoint(btn.frame, loc) && !btn.selected) {
            
            // 设置当前按钮选中
            btn.selected = YES;
            
            // 添加按钮到selectedBtns集合中;
            [self.selectedBtns addObject:btn];
            
            // 一经确认,不再循环
            break;
        }
    }
}

// 触控事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取当前用户触摸点
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:touch.view];
    
    // 判断触控范围归属,设置按钮selected,并汇总集合;
    [self touchesBtnWithLoc:loc];
}

// 拖动事件
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取当前用户触摸点
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:touch.view];
    
    // 记录移动到的当前点
    self.currentP = loc;
    
    // 判断触控范围归属,设置按钮selected,并汇总集合;
    [self touchesBtnWithLoc:loc];
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)clear {
    
    // 重设颜色
    self.lineColor = [UIColor cyanColor];
    
    // 遍历设置所有按钮
    for (UIButton *btn in self.selectedBtns) {
        btn.selected = NO;
        btn.enabled = YES;
    }
    
    // 清空集合
    [self.selectedBtns removeAllObjects];
    
    // 重绘
    [self setNeedsDisplay];
}

// 触控结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 触控结束时,将最后一个按钮中心设置为当前点
    self.currentP = [[self.selectedBtns lastObject] center];

    // 拼接手势密码
    NSMutableString *pwd = [NSMutableString string];
    
    // 遍历选中,拼接btn.tag整型为字符串对象
    for (UIButton *btn in self.selectedBtns) {
        [pwd appendFormat:@"%@", @(btn.tag)];
    }
    NSLog(@"用户输入密码: %@", pwd);
    
    // 验证密码(代理方法)
    BOOL isRight = NO;
    
    // 若代理方法实现则调用方法,验证密码正误
    if ([self.delegate respondsToSelector:@selector(unlockView:withPwd:)]) {
        isRight = [self.delegate unlockView:self withPwd:pwd];
    }
    
    // 根据验证结果操作
    if (isRight) {
        
        NSLog(@"success!");
        // 清空显示
        [self clear];
        
    } else {
        
        // 变更颜色
        self.lineColor = [UIColor redColor];
        // 变更状态
        for (UIButton *btn in self.selectedBtns) {
            btn.selected = NO;
            btn.enabled = NO;
        }
        // 重绘
        [self setNeedsDisplay];
        
        // 此间禁止交互
        self.userInteractionEnabled = NO;
        
        // 延迟清空
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 清空显示,再允许可选;
            [self clear];
            [self.selectedBtns removeAllObjects];
            self.userInteractionEnabled = YES;
        });
    }
}

// 绘制
- (void)drawRect:(CGRect)rect {
    
    // 选中btn大于1才绘制
    if (self.selectedBtns.count <= 1) {
        return;
    }
    
    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 遍历绘制选中按钮中心点
    for (int i = 0; i < self.selectedBtns.count; i++) {
        
        // 选中第一个,该中心绘制起点
        if (i == 0) {
            [path moveToPoint:[self.selectedBtns[i] center]];
        } else {
            [path addLineToPoint:[self.selectedBtns[i] center]];
        }
    }
    
    // 继续绘制到当前点
    [path addLineToPoint:self.currentP];
    
    // 设置渲染颜色
    [self.lineColor set];
    // 渲染
    [path stroke];
}

// 懒加载绘制颜色
- (UIColor *)lineColor {
    if (_lineColor == nil) {
        _lineColor = [UIColor cyanColor];
    }
    return _lineColor;
}

// 懒加载selectedBtns数组
- (NSMutableArray *)selectedBtns {
    if (_selectedBtns == nil) {
        _selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}

@end

