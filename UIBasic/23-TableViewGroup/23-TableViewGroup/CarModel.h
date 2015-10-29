//
//  CarModel.h
//  23-TableViewGroup
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

// 图标名
@property (copy, nonatomic) NSString *icon;
// 车名
@property (copy, nonatomic) NSString *name;

// 字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict;

// 类方法一般以类名开头
+ (instancetype)carWithDict:(NSDictionary *)dict;

@end
