//
//  Flag.m
//  03-NationalFlag
//
//  Created by Aixtuz Kang on 15/6/16.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Flag.h"

@implementation Flag

// 初始化方法
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)flagWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
