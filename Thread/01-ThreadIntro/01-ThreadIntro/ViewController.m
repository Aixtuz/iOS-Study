//
//  ViewController.m
//  01-ThreadIntro
//
//  Created by Aixtuz Kang on 15/7/11.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 为确保UI操作, 耗时操作必须开启新线程
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /*
     for (int i = 0; i < 100000; i++) {
     NSLog(@"%d", i);
     }
     */
    // 新建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(longOperation) object:nil];
    // 线程就绪待命
    [thread start];
}

// 耗时操作
- (void)longOperation {
    for (int i = 0; i < 100000; i++) {
        NSLog(@"%d", i);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
