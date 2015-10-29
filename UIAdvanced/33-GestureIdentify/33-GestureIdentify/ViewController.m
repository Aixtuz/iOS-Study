//
//  ViewController.m
//  33-GestureIdentify
//
//  Created by Aixtuz Kang on 15/6/30.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //!!!: 轻触手势
    // 创建手势识别对象
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    
    // 触发手势的最少触控次数
    tap.numberOfTapsRequired = 2;
    // 触发手势的最少触控点数
    tap.numberOfTouchesRequired = 2;
    
    // 手势识别对象添加到控件中
    [self.imgView addGestureRecognizer:tap];
    
    //!!!: 长按手势
    // 创建手势识别对象
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(langPressGestureAction:)];
    // 最短识别时间
    longPress.minimumPressDuration = 2.0;
    // 长按识别允许误差
    longPress.allowableMovement = 20;
    
    // 手势识别对象添加到控件中
    [self.imgView addGestureRecognizer:longPress];
    
    //!!!: 旋转手势
    // 创建手势识别对象
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureAction:)];
    
    // 设置代理,用于开启多手势同时生效;
    rotation.delegate = self;
    
    // 手势识别对象添加到控件中
    [self.imgView addGestureRecognizer:rotation];
    
    //!!!: 捏合手势
    // 创建手势识别对象
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureAction:)];
    
    // 设置代理,并添加至控件中
    pinch.delegate = self;
    [self.imgView addGestureRecognizer:pinch];
    
    //!!!: 轻扫手势
    // 创建手势识别对象
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    // 添加至控件中
    [self.imgView addGestureRecognizer:swipeLeft];
    [self.imgView addGestureRecognizer:swipeRight];
    
    //!!!: 拖拽手势: 影响轻扫
//    // 创建手势识别对象
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
//    
//    // 添加至控件中
//    [self.imgView addGestureRecognizer:pan];
}

// 监听触控手势后调用的方法（传入参数: 触发控件）
- (void)tapGestureAction:(UITapGestureRecognizer *)recognizer {
    NSLog(@"检测到触控手势");
}

// 监听长按手势后调用的方法（传入参数: 触发控件）
- (void)langPressGestureAction:(UILongPressGestureRecognizer *)recognizer {
    NSLog(@"检测到长按手势");
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 图片透明度闪一下
        [UIView animateWithDuration:1.0 animations:^{
            recognizer.view.alpha = 0.5;
        } completion:^(BOOL finished) {
            recognizer.view.alpha = 1.0;
        }];
    }
}

// 监听旋转手势后调用的方法
- (void)rotationGestureAction:(UIRotationGestureRecognizer *)recognizer {
    // 图片跟随旋转(重置)
    // recognizer.view.transform = CGAffineTransformMakeRotation(recognizer.rotation);
    // 图拼跟随旋转(叠加)
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

// 监听捏合手势后调用的方法
- (void)pinchGestureAction:(UIPinchGestureRecognizer *)recognizer {
    // 图片跟随缩放
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1.0;
}

// 代理允许手势同时
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

// 监听拖拽手势后调用的方法
- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer {
    // 获取拖拽平移值
    CGPoint translation = [recognizer translationInView:recognizer.view];
    // 图片跟随平移
    recognizer.view.transform = CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y);
    // 重置拖拽值
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
}

// 监听轻扫手势后调用的方法
- (void)swipeGestureAction:(UISwipeGestureRecognizer *)recognizer {
    
    // 定义起止点
    CGPoint from = recognizer.view.center;
    CGPoint to;
    
    // 判断划向,计算终点
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        to = CGPointMake(from.x - recognizer.view.bounds.size.width, from.y);
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        to = CGPointMake(from.x + recognizer.view.bounds.size.width, from.y);
    }
    
    // 执行动画
    [UIView animateWithDuration:0.5 animations:^{
        recognizer.view.center = to;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            recognizer.view.center = from;
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
