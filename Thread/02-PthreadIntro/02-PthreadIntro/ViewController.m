//
//  ViewController.m
//  02-PthreadIntro
//
//  Created by Aixtuz Kang on 15/7/11.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "pthread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // __bridge 桥接
    //!!!: MRC: 手动Release
    //!!!: ARC: OC转CF, ARC管理管理内存
    // Foundation
    NSString *str = @"str";
    // Core Foundation
    CFStringRef str0 = (__bridge CFStringRef)str;
    
    //!!!: ARC: CF转OC, 需手动释放转换前的CF, 不归ARC管
    // Core Foundation
    CFStringRef str1 = CFStringCreateWithCString(nil, "CFString", kCFStringEncodingASCII);
    // Foundation
    NSString *str2 = (__bridge NSString *)str1;
    // 手动释放
    CFRelease(str1);
    
    //!!!: 其他桥接方法
    // __bridge_retained 或 CFBridgingRetain() 减少ARC引用, 为0则解除所有权
    // __bridge_transfer 或 CFBridgingRelease() 增加ARC引用, >0则赋予所有权
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 标识一条线程
    pthread_t myThread;
    // 数据
    NSString *str = @"gogogo!";
    // void *  == id, 多态,父类指针统一操作
    void *str0 = (__bridge void *)(str);
    NSLog(@"%@", str0);
    
    // pthread 新线程
    /*
     pthread_create(<#pthread_t *restrict#>, <#const pthread_attr_t *restrict#>, <#void *(*)(void *)#>, <#void *restrict#>)
     - <#pthread_t *restrict#>: 线程地址
     - <#void *(*)(void *)#>: 调用函数
     - <#void *restrict#>: 传入参数
     */
    int result = pthread_create(&myThread, nil, run, str0);
    NSLog(@"%d - %@", result, [NSThread currentThread]);
}

void *run(void *data) {
    
    for (int i = 0; i < 100; i++) {
        NSLog(@"%d - %@ - %@", i, data, [NSThread currentThread]);
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
