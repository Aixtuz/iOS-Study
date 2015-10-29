//
//  ViewController.m
//  16-PerformDelay
//
//  Created by Aixtuz Kang on 15/7/16.
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
    
    /*
    // 延迟执行1: sleep, 效率低
    [NSThread sleepForTimeInterval:3];
    NSLog(@"%@", [NSThread currentThread]);
    
    // 延迟执行2: GCD
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    */
    
    // 延迟执行3: performSelector, 当前线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        // 定制任务
        [self performSelector:@selector(delayTime) withObject:nil afterDelay:3];
        
        // 开启运行循环
        CFRunLoopRun();
        
        // 当前在主线程中, 跳转任务后回不来, 故采用全局并发队列;
        NSLog(@"回不来...");
    });   
}

- (void)delayTime {
    
    // 当前线程
    NSLog(@"%@", [NSThread currentThread]);
    
    // 子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
