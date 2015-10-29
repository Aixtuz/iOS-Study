//
//  ViewController.m
//  21-PieBarChartView
//
//  Created by Aixtuz Kang on 15/6/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"

@interface ViewController ()

//!!!: 通过切换Storyboard中UIView的自定义类, 测试各Demo
// 绿色UIView
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 监听slider
- (IBAction)sliderValueChange:(UISlider *)sender {
    
    // slider的值赋予绿色UIView的属性
    self.progressView.progress = sender.value;
}


@end
