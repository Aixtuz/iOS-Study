//
//  ViewController.m
//  04-ThreadStates
//
//  Created by Aixtuz Kang on 15/7/11.
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
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(longOperation) object:nil];
    [thread start];
}

// 耗时操作: 条件阻塞\退出
- (void)longOperation
{
    for (int i = 0; i < 100; ++i) {
        
        NSLog(@"%d - %@", i, [NSThread currentThread]);
        
        if (i == 30) {
            NSLog(@"睡一会...阻塞");
            //!!!: 阻塞: sleepForTimeInterval:
            [NSThread sleepForTimeInterval:3];
        }
        if (i == 80) {
            //!!!: 退出: exit
            NSLog(@"强制退出,死亡");
            [NSThread exit];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
