//
//  CarModel.m
//  23-TableViewGroup
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

// 字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        // 字典赋予属性
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
    }
    return self;
}

// 类方法一般以类名开头
+ (instancetype)carWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
