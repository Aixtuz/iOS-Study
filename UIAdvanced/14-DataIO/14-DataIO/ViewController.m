//
//  ViewController.m
//  14-DataIO
//
//  Created by Aixtuz Kang on 15/6/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 读
- (IBAction)read:(id)sender {
    
    // 获取路径+文件名
    NSString *path =[self path];
    
    // 文件中去出
    Student *stu = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    // 打印
    NSLog(@"%@ - %d - %d - %@", stu.name, stu.age, stu.DB, stu.stuNO);
}

// 写
- (IBAction)write:(id)sender {
    
    //!!!: 通过归档写入
    // 新建对象,设置数据
    Student *stu = [[Student alloc] init];
    stu.name = @"KK";
    stu.age = 20;
    stu.DB = YES;
    stu.stuNO = @"1";
    
    // 获取路径+文件名
    NSString *path =[self path];
    NSLog(@"%@", path);
    // 写入文件
    [NSKeyedArchiver archiveRootObject:stu toFile:path];
    NSLog(@"写入完毕!");
    
    //!!!: 通过偏好设置写入
    // 创建进行偏好设置读写的对象
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    // 写入数据
    [ud setObject:@"CC" forKey:@"name"];
    [ud setInteger:16 forKey:@"age"];
    [ud setBool:YES forKey:@"DB"];
    
    // 立刻同步
    [ud synchronize];
}

// 获取Documents路径
- (NSString *)path {
    
    // 直接获取沙盒下Documents路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    // 拼接文件名
    NSString *path = [docPath stringByAppendingPathComponent:@"KCL.txt"];
    return path;
}

@end
