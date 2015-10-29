
//
//  Student.m
//  14-DataIO
//
//  Created by Aixtuz Kang on 15/6/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Student.h"

@implementation Student

// 初始化方法 == 反归档: 定义如何读取对象, 即:读.
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.stuNO = [aDecoder decodeObjectForKey:@"user_stuNO"];
    }
    return self;
}

// 实现归档协议中的方法
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.stuNO forKey:@"user_stuNO"];
}

@end
