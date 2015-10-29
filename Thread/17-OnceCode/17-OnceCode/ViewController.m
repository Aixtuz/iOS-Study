//
//  ViewController.m
//  17-OnceCode
//
//  Created by Aixtuz Kang on 15/7/16.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "Singleton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //!!!: 一次性代码, 后续调用无效;
    // GCD
//    [self onceTimeOperation];
//    
//    // performSelector方法
//    [self performSelector:@selector(onceTimeOperation) withObject:nil];
//    
//    // detach
//    [NSThread detachNewThreadSelector:@selector(onceTimeOperation) toTarget:self withObject:nil];
    
    //!!!: 用一次性代码实现单例
    Singleton *obj0 = [[Singleton alloc] init];
    Singleton *obj1 = [Singleton shareSingleton];
    Singleton *obj2 = [Singleton shareSingleton];
    Singleton *obj3 = [Singleton shareSingleton];
    
    // 打印地址观察对象
    NSLog(@"\n%@\n%@\n%@\n%@", obj0, obj1, obj2, obj3);
}

//!!!: 一次性代码
- (void)onceTimeOperation {
    
    // GCD: 一次性代码, 线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"在%@线程, 执行一次", [NSThread currentThread]);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
