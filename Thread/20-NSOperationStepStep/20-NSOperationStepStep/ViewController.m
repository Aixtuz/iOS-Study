//
//  ViewController.m
//  20-NSOperationStepStep
//
//  Created by Aixtuz Kang on 15/7/17.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 定义一个非主队列,用来管理所有的操作
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //!!!: Block中的要用弱引用的self, 避免循环引用
    __weak typeof(self) weakSelf = self;
    // 创建操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
       // 任务
        [weakSelf downloadImage];
    }];
    // Block加入队列,队列就对Block强引用, 类似[self.view addSubview:]方法
    [self.queue addOperation:op];
    
    //!!!: GCD中的self不用转weak, 因为self没有对Block做强引用
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self downloadImage];
    });
}

// 下载任务
- (void)downloadImage
{
    NSLog(@"线程: %@, 执行下载任务.",[NSThread currentThread]);
}

// 懒加载队列
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        // 最大并发数
        [_queue setMaxConcurrentOperationCount:6];
    }
    return _queue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
