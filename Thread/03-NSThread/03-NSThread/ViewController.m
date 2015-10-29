//
//  ViewController.m
//  03-NSThread
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
    
    [self threadCreate1];
    [self threadCreate2];
    [self threadCreate3];
}

//!!!: 多线程实现方案1: 先创建,后启动;
- (void)threadCreate1 {
    // 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(longOperation:) object:@"新建thread111"];
    // 设置
    thread.name = @"name1";
    thread.threadPriority = 0.5; // 优先级 0 ~ 1
    thread.stackSize = 1024 * 1024; // 线程在栈区大小(1M)
    // 就绪待命
    [thread start];
}

//!!!: 多线程实现方案2: 创建完自动启动
- (void)threadCreate2 {
    // 从当前线程分离出新的线程来执行
    [NSThread detachNewThreadSelector:@selector(longOperation:) toTarget:self withObject:@"分离thread222"];
}

//!!!: 多线程实现方案3: 隐式创建(自动启动)
- (void)threadCreate3 {
    // 隐式创建线程: 在后台执行方法
    [self performSelectorInBackground:@selector(longOperation:) withObject:@"隐式thread333"];
}

// 耗时操作
- (void)longOperation:(NSString *)str {
    for (int i = 0; i < 1000; i++) {
        NSLog(@"%d - %@ - %@", i, str, [NSThread currentThread]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
