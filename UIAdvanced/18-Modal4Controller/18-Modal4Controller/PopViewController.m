//
//  PopViewController.m
//  18-Modal4Controller
//
//  Created by Aixtuz Kang on 15/6/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)closeBtn:(UIButton *)sender {
    
    // 如果代理实现了协议方法,则idoayong
//    if ([self.delegate respondsToSelector:@selector(pcDidCloseBtn:)]) {
//        [self.delegate pcDidCloseBtn:self];
//    }
    
    // 或者Modal直接调用dismiss,内部实际仍为代理调用dismiss;
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
