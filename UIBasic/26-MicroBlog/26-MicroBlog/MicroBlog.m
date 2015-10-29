//
//  MicroBlog.m
//  26-MicroBlog
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MicroBlog.h"

@implementation MicroBlog

// 重写构造方法，实现字典转模型
//!!!: 重写构造方法，记得用instancetype返回类型
- (instancetype) initWithDict:(NSDictionary *)dict {
    
    // 先判断父级初始化不为空
    if (self = [super init]) {
        
        // KVC 字典转模型
        //!!!: 模型自身(self)调用 KVC 实现字典转模型, 并返回模型;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

// 类方法常以类名开头
+ (instancetype) microBlogWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

// 定义加载Plist方法，其中调用重写的构造方法，返回D2M后汇总的模型数组
+ (NSMutableArray *)microBlogs {
    
    // 获取plist文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MicroBlogs" ofType:@"plist"];
    
    // 加载plist
    NSArray *dictArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    // 可变数组存储转换后的模型
    //!!!:arrayWithCapacity:创建的数组可用长度
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:dictArray.count];
    
    // 遍历字典转模型
    for (NSDictionary *dict in dictArray) {
        
        // 调用MicroBlog的构造方法
        MicroBlog *microBlog = [[self alloc] initWithDict:dict];
        
        // 可变数组汇总存储
        [tempArray addObject:microBlog];
    }
    return tempArray;
}

@end
