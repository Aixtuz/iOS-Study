//
//  HeroModel.h
//  24-TableViewEdit
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject

// 英雄图标
@property (copy, nonatomic) NSString *icon;
// 英雄名称
@property (copy, nonatomic) NSString *name;
// 英雄简介
@property (copy, nonatomic) NSString *intro;

// 重写init方法,字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict;

// 类方法一般以类名开头
+ (instancetype)heroModelWithDict:(NSDictionary *)dict;

@end

