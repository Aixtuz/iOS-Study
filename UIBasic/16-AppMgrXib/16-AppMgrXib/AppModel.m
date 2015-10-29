//
//  AppModel.m
//  16-AppMgrXib
//
//  Created by Aixtuz Kang on 15/5/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

//!!!: 重写构造方法实现封装字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    // //!!!: 重写init方法注意：先判断父级init不为空,才进行初始化;
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
    }
    return self;
    
}

// 类方法一般用类名开头
+ (instancetype)appModelWithDict:(NSDictionary *)dict {
    
    // 类创建对象：[self alloc] 再调用对象方法：initWithDict：
    return [[self alloc] initWithDict:dict];
    
}

@end
