//
//  CarGroup.m
//  23-TableViewGroup
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "CarGroup.h"
#import "CarModel.h"

@implementation CarGroup

//!!!: 重写init注意：动态检测返回类型（字典转模型，其中cars字典数组继续转模型数组）
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        // 字典键值赋值属性
        self.title = dict[@"title"];
        self.cars = dict[@"cars"];
        self.end = dict[@"end"];
        
        // 可变数组存储模型
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        // 遍历字典转模型
        for (NSDictionary *dict in self.cars) {
            
            // 字典转模型
            CarModel *carModel = [CarModel carWithDict:dict];
            
            // 数组存储模型
            [tempArray addObject:carModel];
        }
        self.cars = tempArray;
    }
    return self;
}

+ (instancetype)carGroupWithDict:(NSDictionary *)dict {
    
    // 创建调用者类型的对象，再调用对象方法
    return [[self alloc] initWithDict:dict];
}

@end
