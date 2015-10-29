

//
//  Person.m
//  14-DataIO
//
//  Created by Aixtuz Kang on 15/6/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Person.h"

@implementation Person

// 初始化方法 == 反归档: 定义如何读取对象, 即:读.
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"user_name"];
        // IntegerForKey vs IntForKey
        self.age = [aDecoder decodeIntForKey:@"user_age"];
        self.DB = [aDecoder decodeBoolForKey:@"user_isDB"];
    }
    return self;
}


// 实现归档协议中的方法
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    // 归档: 定义如何存储对象, 即:写.
    [aCoder encodeObject:self.name forKey:@"user_name"];
    [aCoder encodeInteger:self.age forKey:@"user_age"];
    [aCoder encodeBool:self.isDB forKey:@"user_isDB"];
}


@end
