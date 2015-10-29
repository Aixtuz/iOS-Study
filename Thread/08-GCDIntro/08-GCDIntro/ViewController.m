//
//  ViewController.m
//  08-GCDIntro
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
    
    //!!!: 创建队列
    /*
     <#dispatch_queue_attr_t attr#> 标识队列类型
      - 串行队列: DISPATCH_QUEUE_SERIAL
      - 并发队列: DISPATCH_QUEUE_CONCURRENT
     */
    
    // 创建串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    
    //创建并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 获取全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    //!!!: 执行函数
    
    // 同步
    dispatch_sync(serialQueue, ^{
        NSLog(@"同步执行串行队列任务");
    });
    
    // 异步
    dispatch_async(concurrentQueue, ^{
        NSLog(@"异步执行并发队列任务");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
