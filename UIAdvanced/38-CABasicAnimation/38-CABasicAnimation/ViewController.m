//
//  ViewController.m
//  38-CABasicAnimation
//
//  Created by Aixtuz Kang on 15/7/8.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Layer 属性
@property (nonatomic, weak) CALayer *myLayer;

// DemoView
@property (nonatomic, weak) UIView *demoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本操作
    /*
     // 创建Layter
     CALayer *myLayer = [CALayer layer];
     // 设置Layer
     myLayer.bounds = CGRectMake(0, 0, 100, 100);
     myLayer.position = CGPointMake(100, 200);
     myLayer.backgroundColor = [UIColor cyanColor].CGColor;
    
     // 设置归属
     [self.view.layer addSublayer:myLayer];
     // 属性引用
     self.myLayer = myLayer;
     */
    
    // 基础动画
    UIView *demoView = [[UIView alloc] init];
    // 设置demoView
    demoView.bounds = CGRectMake(0, 0, 100, 100);
    demoView.backgroundColor = [UIColor cyanColor];
    demoView.center = CGPointMake(100, 100);
    // 设置归属
    [self.view addSubview:demoView];
    // 属性引用
    self.demoView = demoView;
}

// 触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //!!!: 基本操作
    /*
    // 创建一个带key的基础动画;
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    // 为动画设置代理
    anim.delegate = self;
    
    // 设置动画对象的属性
    anim.toValue = @(300);
    
    // 设置动画执行时间
    anim.duration = 1.0;
    
    // 结束后是否移除动画状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    // 把动画对象添加到对应的layer中
    [self.myLayer addAnimation:anim forKey:@"anim1"];
     */
    
    // 基础动画01: 单轴移动
    /*
     CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
     
     // 设置anim
     anim.toValue = @(300);
     anim.duration = 1.0;
     anim.delegate = self;
     
     // 是否移除动画状态
     anim.removedOnCompletion = NO;
     anim.fillMode = kCAFillModeForwards;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:@"anim1"];
     */
    
    // 基础动画02: 平面移动+循环
    /*
     CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
     
     // 设置anim
     anim.byValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
     anim.duration = 1.0;
     anim.delegate = self;
     
     // 重复次数
     anim.repeatCount = CGFLOAT_MAX;
     
     // 是否移除动画状态
     anim.removedOnCompletion = NO;
     anim.fillMode = kCAFillModeForwards;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:@"anim1"];
     */
    
    // 基础动画03: 定轴旋转
    /*
     CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
     
     // 设置anim
     // toValue: 赋值
     // anim.toValue = @(M_PI_4);
     // byValue: 累加
     anim.byValue = @(M_PI_4);
     anim.duration = 1.0;
     
     // 重复次数
     anim.repeatCount = CGFLOAT_MAX;
     
     // 是否移除动画状态
     anim.removedOnCompletion = NO;
     anim.fillMode = kCAFillModeForwards;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:nil];
     */
    
    // 基础动画04: 连续旋转
    /*
     CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
     
     // 设置anim
     // anim.toValue = @(M_PI * 2);
     anim.byValue = @(M_PI * 2);
     anim.duration = 1.0;
     
     // 重复次数
     anim.repeatCount = CGFLOAT_MAX;
     
     // 是否移除动画状态
     anim.removedOnCompletion = NO;
     anim.fillMode = kCAFillModeForwards;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:nil];
     */
    
    // 基础动画05: 连续旋转2
    /*
     CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
     
     // 设置anim
     // anim.toValue = @(M_PI_4 * 0.5);
     anim.byValue = @(M_PI_4 * 0.5);
     anim.duration = 0.5;
     
     // 是否移除动画状态
     anim.removedOnCompletion = NO;
     anim.fillMode = kCAFillModeForwards;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:nil];
     */
    
    // 基础动画06: 缩放
    /*
     CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
     
     // 设置anim
     // anim.toValue = @(0.2);
     anim.byValue = @(0.2);
     anim.duration = 1.0;
     
     // 重复次数
     anim.repeatCount = CGFLOAT_MAX;
     
     // 是否移除动画状态
     anim.removedOnCompletion = NO;
     anim.fillMode = kCAFillModeForwards;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:nil];
     */
    
    // 基础动画07: 关键帧动画
    /*
     CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
     
     // 定义帧
     NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
     NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
     NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
     NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(300, 100)];
     
     // 设置anim
     anim.values = @[v1, v2, v3, v4, v1];
     anim.duration = 2.0;
     
     // 重复次数
     anim.repeatCount = CGFLOAT_MAX;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:nil];
     */
    
    // 基础动画08: 按路径执行关键帧动画
    /*
     CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
     
     // 过渡类型
     anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     
     // 设置anim
     anim.duration = 1.0;
     anim.repeatCount = CGFLOAT_MAX;
     
     // 是否移除动画状态
     anim.removedOnCompletion = NO;
     anim.fillMode = kCAFillModeForwards;
     
     // 路径对象
     UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 200, 200)];
     anim.path = path.CGPath;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:nil];
     */
    
    // 基础动画09: 图标抖动
    /*
     CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
     
     // 设置anim
     anim.values = @[@(-M_PI_4 * 0.1), @(M_PI_4 * 0.1), @(-M_PI_4 * 0.1)];
     
     // 重复次数
     anim.repeatCount = 999;
     
     // 为layer添加动画
     [self.demoView.layer addAnimation:anim forKey:nil];
     */
    
    // 组动画
    CAAnimationGroup *animGroup = [[CAAnimationGroup alloc] init];
    
    // 关键帧动画
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置anim1
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 150)];
    anim1.path = path.CGPath;
    
    // 旋转动画
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设置anim2
    anim2.toValue = @(M_PI_2);
    anim2.duration = 0.1;
    anim2.repeatCount = CGFLOAT_MAX;
    
    // 缩放动画
    CABasicAnimation *anim3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 设置anim3
    anim3.toValue = @(0.1);
    
    // 动画汇总到组
    animGroup.animations = @[anim1, anim2, anim3];
    // 设置animGroup
    animGroup.duration = 2.0;
    animGroup.repeatCount = CGFLOAT_MAX;
    
    // 是否移除动画状态
    animGroup.removedOnCompletion = NO;
    animGroup.fillMode = kCAFillModeForwards;
    
    // 为layer添加组动画
    [self.demoView.layer addAnimation:animGroup forKey:nil];
}

// 动画开始
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"--- 动画启开始 ---");
}

// 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    // 设置layer的position为真正的动画结束位置
    // self.myLayer.position = CGPointMake(300, 200);
    
    NSLog(@"--- 动画启结束 ---");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
