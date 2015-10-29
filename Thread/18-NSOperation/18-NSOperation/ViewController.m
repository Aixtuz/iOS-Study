//
//  ViewController.m
//  18-NSOperation
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
    
    //!!!: 多操作加入非主队列 = GCD (异步函数 + 全局并发);
    // 创建非主操作队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(longTimeOperation) object:nil];
    
    // 操作加入队列
    [queue addOperation:op];
    
    // 创建多个操作
    for (int i = 0; i < 5; i++) {
        NSBlockOperation *bop = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"线程:%@ 正在执行追加任务1",[NSThread currentThread]);
        }];
        // 操作加入队列
        [queue addOperation:bop];
    }
}


- (void)blockOperation {
    /*
     // 创建操作
     NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(longTimeOperation) object:nil];
     
     //!!!: 当前线程执行任务, 注释掉后尝试放入队列;
     // [op start];
     
     //!!!: 将操作加入队列, 根据队列类型自动选择线程
     // 主队列: 主线程;
     // 非主队列: 子线程;
     // 二选一
     
     // 获取主队列
     // NSOperationQueue *queue = [NSOperationQueue mainQueue];
     // 创建非主队列
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
     
     //!!!: 操作放入队列: 注释后尝试块代码
     [queue addOperation:op];
     */
    
    //!!!: NSBlockOperation: 封装任务>1,直接 start/置入主队列,不同线程执行
    NSBlockOperation *bop = [NSBlockOperation blockOperationWithBlock:^{
        // 任务放在block中,直接调用
        [self longTimeOperation];
    }];
    
    // 追加任务
    [bop addExecutionBlock:^{
        NSLog(@"线程:%@ 正在执行追加任务1",[NSThread currentThread]);
    }];
    [bop addExecutionBlock:^{
        NSLog(@"线程:%@ 正在执行追加任务2",[NSThread currentThread]);
    }];
    
    // 直接start
    //[bop start];
    
    // 放入主队列
    [[NSOperationQueue mainQueue] addOperation:bop];
    
    // 回到子线程
    // 创建非主队列
    // NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // [queue addOperation:bop];
    
    //!!!: GCD执行效率更高,金丹开启子线程任务,一般选: GCD, 异步函数 + 全局并发队列;
}

// 模拟耗时操作
- (void)longTimeOperation
{
    NSLog(@"线程:%@ 正在进行耗时操作",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
