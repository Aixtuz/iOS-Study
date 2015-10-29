//
//  Contact.h
//  29-QQContacts
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

// 图标
@property (copy, nonatomic) NSString *icon;
// 名称
@property (copy, nonatomic) NSString *name;
// 简介
@property (copy, nonatomic) NSString *intro;
// vip
@property (assign, nonatomic, getter=isVip) BOOL vip;


// 初始化方法
- (instancetype)initWithDict:(NSDictionary *)dict;

// 类方法初始化
+ (instancetype)contactWithDict:(NSDictionary *)dict;

@end

