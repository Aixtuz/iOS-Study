//
//  ViewController.m
//  36-CALayer
//
//  Created by Aixtuz Kang on 15/7/7.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 属性记录Layer
@property (nonatomic, weak) CALayer *myLayer;
@property (nonatomic, weak) CALayer *myLayer0;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 全局背景
    self.view.backgroundColor = [UIColor grayColor];
    
    // 创建一个View
    UIView *myView = [[UIView alloc] init];
    // frame
    myView.frame = CGRectMake(100, 100, 100, 100);
    // backgroundColor
    myView.backgroundColor = [UIColor whiteColor];
    // addSubview
    [self.view addSubview:myView];
    
    // 设置Layer
    [self setLayerForView:myView];
    
    // myLayer0
    CALayer *myLayer0 = [CALayer layer];
    myLayer0.bounds = CGRectMake(0, 0, 150, 200);
    myLayer0.backgroundColor = [UIColor redColor].CGColor;
    // 定义了锚点为左下角(0，0)
    myLayer0.anchorPoint = CGPointMake(0, 0);
    myLayer0.position = CGPointMake(0, 200);
    [self.view.layer addSublayer:myLayer0];
    self.myLayer0 = myLayer0;
}

// 设置Layer
- (void)setLayerForView:(UIView *)myView {
    
    //!!!: CALayer: 转CGColor,CGImage
    CALayer *myLayer = myView.layer;
    
    // border
    myLayer.borderWidth = 5;
    myLayer.borderColor = ([UIColor cyanColor].CGColor);
    
    // opacity
    myLayer.opacity = 0.8;
    
    // shadow
    myLayer.shadowColor = [UIColor greenColor].CGColor;
    myLayer.shadowOffset = CGSizeMake(1, 2);
    myLayer.shadowRadius = 2;
    myLayer.shadowOpacity = 0.5;
    
    // radius
    myLayer.cornerRadius = myView.bounds.size.width * 0.5;
    myLayer.masksToBounds = YES;
    
    // image
    myLayer.contents = (__bridge id)([UIImage imageNamed:@"me"].CGImage);
    
    // 赋予属性
    self.myLayer = myLayer;
}

// 触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取触摸点
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:touch.view];
    
    // Layer控制View
    // self.myLayer.position = loc;
    // self.myLayer.bounds = CGRectMake(0, 0, 200, 100);
    
    // 核心动画
    // 平移
    // self.myLayer.transform = CATransform3DTranslate(self.myLayer.transform, 10, 10, 10);
    // 缩放
    // self.myLayer.transform = CATransform3DScale(self.myLayer.transform, 0.5, 0.5, 0);
    // 旋转
    // self.myLayer.transform = CATransform3DRotate(self.myLayer.transform, M_PI_4, 10, 10, 10);
    
    // 禁用隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    // CA均默认隐式动画,写在此间除外；
    [CATransaction commit];
    
    //!!!: position是layer中的anchorPoint点在superLayer中的位置坐标。
    //!!!: 锚点预设(0,0),然后变化: position不变(锚点相对父控件不变,view调整位置);
    if (self.myLayer0.anchorPoint.x == 0 && self.myLayer0.anchorPoint.y == 0) {
        self.myLayer0.anchorPoint = CGPointMake(1, 0);
    } else {
        self.myLayer0.anchorPoint = CGPointMake(0, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
