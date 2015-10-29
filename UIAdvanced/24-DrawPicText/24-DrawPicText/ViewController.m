//
//  ViewController.m
//  24-DrawPicText
//
//  Created by Aixtuz Kang on 15/6/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //!!!: 背景色,colorWithPatternImage绘制图片UIImage
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Press"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
