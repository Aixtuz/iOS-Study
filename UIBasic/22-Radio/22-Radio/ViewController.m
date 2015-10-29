//
//  ViewController.m
//  22-Radio
//
//  Created by Aixtuz Kang on 15/5/31.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *lastImage;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 滚动滚动范围
    CGFloat ScrollW = 0;
    CGFloat ScrollH = self.lastImage.frame.origin.y + 150;
    NSLog(@"%f", ScrollH);
    
    // 设置滚动范围
    self.ScrollView.contentSize = CGSizeMake(ScrollW, ScrollH);
    
    // 设置初始位置
    // self.ScrollView.contentOffset = CGPointMake(0, 0);
}


@end
