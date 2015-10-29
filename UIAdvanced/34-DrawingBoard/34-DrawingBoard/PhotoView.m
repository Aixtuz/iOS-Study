//
//  PhotoView.m
//  34-DrawingBoard
//
//  Created by Aixtuz Kang on 15/7/4.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "PhotoView.h"

@interface PhotoView () <UIGestureRecognizerDelegate>

// imageView属性
@property(nonatomic, weak) UIImageView *imgView;

@end

@implementation PhotoView


// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame photo:(UIImage *)image {
    if (self = [super initWithFrame:frame]) {
        
        // 根据传入的image创建imageView
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        
        // 允许图片交互和多点
        imgView.userInteractionEnabled = YES;
        imgView.multipleTouchEnabled = YES;
        
        // 加入视图中
        [self addSubview:imgView];
        
        // 属性引用
        self.imgView = imgView;
        
        // 为图片添加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [imgView addGestureRecognizer:pan];
        
        // 旋转手势
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureAction:)];
        rotation.delegate = self;
        [imgView addGestureRecognizer:rotation];
        
        // 捏合手势
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureAction:)];
        pinch.delegate = self;
        [imgView addGestureRecognizer:pinch];
        
        // 长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
        [imgView addGestureRecognizer:longPress];
    }
    return self;
}

+ (instancetype)photoViewWithFrame:(CGRect)frame photo:(UIImage *)image {
    return [[self alloc] initWithFrame:frame photo:image];
}

// 手势识别的代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// 拖拽
- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:recognizer.view];
    recognizer.view.transform = CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y);
    
    // 重置
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
}

// 旋转
- (void)rotationGestureAction:(UIRotationGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

// 捏合
- (void)pinchGestureAction:(UIPinchGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    
    recognizer.scale = 1.0;
}

// 长按
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)recognizer
{
    // 闪烁
    [UIView animateWithDuration:0.5 animations:^{
        recognizer.view.alpha = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            recognizer.view.alpha = 1;
        } completion:^(BOOL finished) {

            // 开启一个图片上下文
            UIGraphicsBeginImageContext(self.bounds.size);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            
            // 把当前View渲染到上下文中
            [self.layer renderInContext:ctx];
            
            // 从上下文中获取图片
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            
            // 结束上下文
            UIGraphicsEndImageContext();
            
            // 判断是否有代理方法
            if ([self.delegate respondsToSelector:@selector(photoView:image:)]) {
                [self.delegate photoView:self image:img];
            }
            
        }];
    }];
    
}

// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGPoint centerP = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    self.imgView.center = centerP;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
