//
//  MicroBlog.h
//  26-MicroBlog
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MicroBlog : NSObject

//!!!: 数据模型用属性传递数据,属性不能是私有的。
// 头像
@property (copy, nonatomic) NSString *icon;
// 昵称
@property (copy, nonatomic) NSString *name;
// Vip
@property (assign, nonatomic, getter=isVip) BOOL vip;
// 文本
@property (copy,nonatomic) NSString *text;
// 图片
@property (copy,nonatomic) NSString *pic;

// 重写构造方法，实现字典转模型
- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) microBlogWithDict:(NSDictionary *)dict;

// 定义加载Plist方法，其中调用重写的构造方法，返回D2M后汇总的模型数组
+ (NSMutableArray *)microBlogs;

@end
