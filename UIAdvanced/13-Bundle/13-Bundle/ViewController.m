//
//  ViewController.m
//  13-Bundle
//
//  Created by Aixtuz Kang on 15/6/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //!!!: 输出Bundle目录
    NSString *bundle = [NSBundle mainBundle].bundlePath;
    NSLog(@"%@", bundle);
    
    //!!!: 输出沙盒目录
    NSString *sandBox = NSHomeDirectory();
    NSLog(@"%@", sandBox);
    
    // 获取沙盒下Documents目录
    // NSString *doc = [NSString stringWithFormat:@"%@/Documents", sandBox];
    //!!!: 如果用stringByAppendingString,则纯字符拼接,无路径符号:"/"
    NSString *doc = [sandBox stringByAppendingPathComponent:@"Documents"];
    NSLog(@"%@", doc);
    
    //!!!: 直接获取Documents路径, NSSearchPathForDirectoriesInDomains返回数组, BOOL参数:是否将波浪线显示为完整路径;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO) lastObject];
    NSLog(@"%@", docPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
