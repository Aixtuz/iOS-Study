//
//  Singleton.m
//  17-OnceCode
//
//  Created by Aixtuz Kang on 15/7/16.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

// 静态变量保存单例对象
static id _instance;

// 获取单例对象的方法1: 自定义方法, 仅当此法为单例
+ (instancetype)shareSingleton {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化单例对象
        _instance = [[self alloc] init];
    });
    return _instance;
}

// 获取单例对象的方法2: 重写方法, alloc + init始终单例;
/*
 + (instancetype)allocWithZone:(struct _NSZone *)zone {
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 // 初始化单例对象
 _instance = [self allocWithZone:zone];
 });
 return _instance;
 }
 */

@end
