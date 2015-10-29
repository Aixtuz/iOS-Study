//
//  App.h
//  24-AppListOL
//
//  Created by Aixtuz Kang on 15/7/19.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject

// 模型属性
// 名称
@property (nonatomic, copy) NSString *name;
// 下载数
@property (nonatomic, copy) NSString *download;
// 图标
@property (nonatomic, copy) NSString *icon;

// 字典转模型的初始化方法
+ (instancetype)appWithDict:(NSDictionary *)dict;

@end
