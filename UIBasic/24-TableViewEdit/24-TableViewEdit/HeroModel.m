//
//  HeroModel.m
//  24-TableViewEdit
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel

// 重写init方法,字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        //TODO: KVC实现字典转模型
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
        self.intro = dict[@"intro"];
    }
    return self;
}

// 类方法一般以类名开头
+ (instancetype)heroModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
