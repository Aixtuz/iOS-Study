//
//  ViewController.m
//  12-NSRunLoop
//
//  Created by Aixtuz Kang on 15/7/13.
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

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 异步函数 + 全局并发队列: 开启子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 计时器
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(longOperation) userInfo:nil repeats:YES];
        
        // 计时器加入当前运行循环
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        // 开启运行循环
        CFRunLoopRun();
        // [[NSRunLoop currentRunLoop] run];
        
        // 强制退出线程
        [NSThread exit];
    });
}

// 耗时操作
- (void)longOperation {
    
    static int num = 0;
    NSLog(@"----%d",num++);
    
    if (num == 10) {
        // 关闭运行循环
        CFRunLoopStop(CFRunLoopGetCurrent());
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

