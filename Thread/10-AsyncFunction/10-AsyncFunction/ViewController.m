//
//  ViewController.m
//  10-AsyncFunction
//
//  Created by Aixtuz Kang on 15/7/12.
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
    
    //!!!: 异步函数 + 串行队列: 多队列开启多线程, 队列内顺序执行;
    // 创建串行队列
    /*
     // 创建串行队列
     dispatch_queue_t queue1 = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
     dispatch_queue_t queue2 = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
     
     // 异步函数执行
     [self gcdAsyncWithQueue:queue1];
     [self gcdAsyncWithQueue:queue2];
     */
    
    //!!!: 异步函数 + 并发队列: 多线程并发执行
    /*
     // 获取全局并发队列
     dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
     dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
     
     // 异步函数执行
     [self gcdAsyncWithQueue:queue1];
     [self gcdAsyncWithQueue:queue2];
     */
    
    //!!!: 回主线程方法
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"当前队列:%@,执行任务", [NSThread currentThread]);
    });
    
    //!!!: 异步函数 + 主队列: 主线程, 顺序执行
    [self gcdAsyncWithQueue:dispatch_get_main_queue()];
}

// 异步函数
- (void)gcdAsyncWithQueue:(dispatch_queue_t)queue {
    
    // 异步函数执行
    dispatch_async(queue, ^{
        NSLog(@"当前队列%@, 执行任务1", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"当前队列%@, 执行任务2", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"当前队列%@, 执行任务3", [NSThread currentThread]);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
