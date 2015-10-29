//
//  ViewController.m
//  35-GestureUnlock
//
//  Created by Aixtuz Kang on 15/7/5.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "UnlockView.h"

@interface ViewController () <UnlockViewDelegate>

// 监听unlockView
@property (weak, nonatomic) IBOutlet UnlockView *unlockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //!!!: 以图片绘制背景: colorWithPatternImage
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomeButtomBG"]];
    
    // 设置代理
    self.unlockView.delegate = self;
}

// 实现代理方法
- (BOOL)unlockView:(UnlockView *)unlockView withPwd:(NSString *)pwd {
    if ([pwd isEqualToString:@"13457"]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
