//
//  App.m
//  24-AppListOL
//
//  Created by Aixtuz Kang on 15/7/19.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "App.h"

@implementation App

// 字典转模型的初始化方法
+ (instancetype)appWithDict:(NSDictionary *)dict {
    
    // 新建模型
    App *app = [[App alloc] init];
    
    // KVC解析数据
    [app setValuesForKeysWithDictionary:dict];
    
    return app;
}

@end
