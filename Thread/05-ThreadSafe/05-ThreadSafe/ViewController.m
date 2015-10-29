//
//  ViewController.m
//  05-ThreadSafe
//
//  Created by Aixtuz Kang on 15/7/11.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 余票
@property(nonatomic, assign) NSInteger tickets;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 线程按顺序执行 - 线程同步技术
    // 互斥锁: 唯一锁对象, 耗费性能, 锁定尽可能小的内容
}

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tickets = 100;
    // 三窗口,三线程
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets:) object:@"1号窗口"];
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets:) object:@"2号窗口"];
    NSThread *thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets:) object:@"3号窗口"];
    // 就绪待命
    [thread1 start];
    [thread2 start];
    [thread3 start];
}

// 买票方法
- (void)saleTickets:(NSString *)window {
    // @synchronized(锁对象self){  /*需要锁住的代码,越少越好!*/ }
    
    while (YES) {
        @synchronized(self.view) {
            // 加锁内容
            if (self.tickets > 0) {
                self.tickets --;
                NSLog(@"%@售出, 余%ld - %@", window, (long)self.tickets, [NSThread currentThread]);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
