//
//  ViewController.m
//  09-SyncFunction
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
    
    //!!!: 同步函数 + 串行队列: 当前线程,顺序执行任务;
    /*
     // 创建串行队列
     dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
     
     // 同步函数执行
     [self gcdSyncWithQueue:queue];
     */
    
    //!!!: 同步函数 + 并发队列: 当前线程顺序执行
    /*
     // 获取全局并发队列
     dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
     
     // 同步函数执行
     [self gcdSyncWithQueue:queue];
     */
    
    //!!!: 同步函数 + 主队列: 当前为主线程, 主线程&主队列相互等待, 阻塞;
    /*
     [self gcdSyncTest];
     */
    
    //!!!: 同步函数 + 主队列: 当前非主线程, 主线程顺序执行;
    // 非主线程执行方法
    [self performSelectorInBackground:@selector(gcdSyncTest) withObject:nil];
}

- (void)gcdSyncWithQueue:(dispatch_queue_t)queue {
    
    // 同步函数执行
    dispatch_sync(queue, ^{
        NSLog(@"当前队列:%@,执行任务1", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"当前队列:%@,执行任务2", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"当前队列:%@,执行任务3", [NSThread currentThread]);
    });
}

- (void)gcdSyncTest {
    
    // 同步函数执行(其中获取主队列)
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"当前队列:%@,执行任务1", [NSThread currentThread]);
    });
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"当前队列:%@,执行任务2", [NSThread currentThread]);
    });
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"当前队列:%@,执行任务3", [NSThread currentThread]);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
