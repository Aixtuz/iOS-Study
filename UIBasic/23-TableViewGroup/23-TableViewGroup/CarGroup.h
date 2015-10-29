//
//  CarGroup.h
//  23-TableViewGroup
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarGroup : NSObject

// 组标题
@property (copy, nonatomic) NSString *title;
// 组元素
@property (strong, nonatomic) NSArray *cars;
// 组尾巴
@property (copy, nonatomic) NSString *end;

// 字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict;
// 类方法一般以类名开头
+ (instancetype)carGroupWithDict:(NSDictionary *)dict;

@end
