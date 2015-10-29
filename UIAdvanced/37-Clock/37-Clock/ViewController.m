//
//  ViewController.m
//  37-Clock
//
//  Created by Aixtuz Kang on 15/7/8.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 秒针属性
@property (nonatomic, weak) UIView *secView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建View
    UIView *clockView = [[UIView alloc] init];
    // bounds
    clockView.bounds = CGRectMake(0, 0, 150, 150);
    // center
    clockView.center = CGPointMake(200, 200);
    // contents
    clockView.layer.contents = (__bridge id)([UIImage imageNamed:@"clock"].CGImage);
    // 剪裁
    clockView.layer.cornerRadius = 75;
    clockView.layer.masksToBounds = YES;
    // 添加控件
    [self.view addSubview:clockView];
    
    // 创建秒针
    UIView *sec = [[UIView alloc] init];
    // 设置属性
    sec.bounds = CGRectMake(0, 0, 1, 60);
    sec.center = clockView.center;
    sec.layer.backgroundColor = [UIColor cyanColor].CGColor;
    // 添加控件
    [self.view addSubview:sec];
    // 属性引用
    self.secView = sec;
    
    //!!!: 点默认(0.5,0.5),修改后锚点相对父控件位置不变,view挪动去匹配新锚点位置;
    sec.layer.anchorPoint = CGPointMake(0.5, 0.8);
    
    // 秒针转动
    [self secTurn];
    
    // 相比NSTimer，CADisplayLink确保系统渲染每一帧时方法都被调用,保证动画流畅性。
    // NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(secTurn) userInfo:nil repeats:YES];
    CADisplayLink *display = [CADisplayLink displayLinkWithTarget:self selector:@selector(secTurn)];
    [display addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

// 秒针转动
- (void)secTurn {
    // 计算每秒弧度
    CGFloat angle = M_PI * 2 / 60;
    
    // 当前时间
    NSDate *date = [NSDate date];
    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //!!!: 获取秒数,NSCalendar对象的component方法;
    NSInteger sec = [calendar component:NSCalendarUnitSecond fromDate:date];
    
    // 旋转角度
    self.secView.transform = CGAffineTransformMakeRotation(angle * sec);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
