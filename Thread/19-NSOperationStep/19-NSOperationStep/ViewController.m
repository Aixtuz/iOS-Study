//
//  ViewController.m
//  19-NSOperationStep
//
//  Created by Aixtuz Kang on 15/7/17.
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
    
    [self addDependencyOperation];
}

// 操作依赖
- (void)addDependencyOperation {
    
    // 创建操作队列
    NSOperationQueue *queue0 = [[NSOperationQueue alloc] init];
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    
    // 创建Invocation操作
    NSInvocationOperation *op0 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    // 创建Block操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"线程:%@,开始执行任务:Block1",[NSThread currentThread]);
    }];
    
    //!!!: 一般不这样写, 别人猜不出block类型;
    // 操作执行后回调
    op1.completionBlock = ^{
        NSLog(@"op0执行完毕.");
    };
    // 创建操作
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"线程:%@,开始执行任务:Block2",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"线程:%@,开始执行任务:Block3",[NSThread currentThread]);
    }];
    // 操作执行后回调
    op3.completionBlock = ^{
        NSLog(@"op3执行完毕.");
    };
    
    // 设置依赖, 避免循环依赖
    [op0 addDependency:op1];
    [op1 addDependency:op2];
    [op3 addDependency:op0];
    
    // 操作加入队列, 操作>1 / Start,操作即自动执
    [queue0 addOperation:op1];
    [queue0 addOperation:op2];
    [queue1 addOperation:op3];
    [queue1 addOperation:op0];
}

// 操作控制
- (void)operationControl {
    
    // 创建操作队列
    NSOperationQueue *queue0 = [[NSOperationQueue alloc] init];
    
    // 创建Invocation操作
    NSInvocationOperation *op0 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    // 创建Block操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"线程:%@,开始执行任务:Block",[NSThread currentThread]);
    }];
    
    //!!!: 取消操作
    // 取消单个操作:
    [op0 cancel];
    // 取消队列全体:
    [queue0 cancelAllOperations];
    
    // 操作暂停与恢复
    [queue0 setSuspended:YES];
    [queue0 setSuspended:NO];
}

// 自定义操作
- (void)downloadImage {
    NSLog(@"线程:%@,开始执行任务:download",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
