//
//  ViewController.m
//  11-TaskAssign
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
    
    //!!!: 异步函数 + 串行队列: 单子线程顺序执行
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    
    // 异步函数
    [self gcdAsyncWith:queue];
    
    //!!!: 异步函数 + 主队列: 主线程顺序执行
    [self gcdAsyncWith:dispatch_get_main_queue()];
}

// 异步函数
- (void)gcdAsyncWith:(dispatch_queue_t)queue {
    
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
