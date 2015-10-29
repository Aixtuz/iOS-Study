//
//  Person.h
//  14-DataIO
//
//  Created by Aixtuz Kang on 15/6/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

// 遵守归档协议,使用归档方法;
@interface Person : NSObject <NSCoding>

// 姓名
@property (nonatomic, copy) NSString *name;
// 年龄
@property (nonatomic, assign) int age;
// BOOL
@property (nonatomic, assign, getter=isDB) BOOL DB;

@end
