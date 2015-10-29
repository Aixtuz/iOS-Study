//
//  GroupBuy.m
//  25-GroupBuy
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "GroupBuy.h"

#import "GroupBuy.h"

@implementation GroupBuy

//!!!: 字典转模型，重写init方法，返回模型，instancetype动态检测返回类型
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    //!!!: 重写init，先初始化父类
    if (self = [super init]) {
        // KVC 字典转模型
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

// 类方法一般以类名开头
+ (instancetype)groupBuyWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

// 装载plist
+ (NSMutableArray *)groupBuys {
    
    // 获取plist路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
    
    // 加载plist
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    
    // 汇总存储模型
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (NSDictionary *dict in dictArray) {
        
        // 调用字典转模型方法(init)
        GroupBuy *groupBuy = [[self alloc] initWithDict:dict];
        
        // 汇总模型
        [tempArray addObject:groupBuy];
    }
    
    // 谁调用加载plist方法，就返回最终的模型数组给谁
    return tempArray; //!!!: 此处直接返回可变数组,VC中声明实现以及调用此句的懒加载,都要换成NSMutableArray;
}

@end
