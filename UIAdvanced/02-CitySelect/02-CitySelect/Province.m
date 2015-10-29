//
//  Province.m
//  02-CitySelect
//
//  Created by Aixtuz Kang on 15/6/15.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Province.h"

@implementation Province

// 初始化方法
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init] ) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)provinceWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
