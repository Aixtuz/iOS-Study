//
//  ViewController.m
//  13-ThreadSleep
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
    
    //!!!: 阻塞式函数:
    /*
     - 当前队列中:
     * 完成前置任务, 才执行阻塞任务;
     * 完成阻塞任务, 才执行后续任务;
     * 阻塞前后, 随机顺序
     */
    // 异步函数 + 并发队列
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"当前队列%@, 执行任务1", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"当前队列%@, 执行任务2", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"当前队列%@, 执行任务3", [NSThread currentThread]);
    });
    
    // 异步函数 + 全局并发队列
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"当前队列%@, 执行任务4", [NSThread currentThread]);
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"当前队列%@, 执行任务5", [NSThread currentThread]);
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"当前队列%@, 执行任务6", [NSThread currentThread]);
    });
    
    // 阻塞式函数
    dispatch_barrier_sync(queue, ^{
        NSLog(@"当前队列%@, 执行阻塞式任务", [NSThread currentThread]);
    });
    
    // 异步函数 + 全局并发队列
    dispatch_async(queue, ^{
        NSLog(@"当前队列%@, 执行任务", [NSThread currentThread]);
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"当前队列%@, 执行任务", [NSThread currentThread]);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
