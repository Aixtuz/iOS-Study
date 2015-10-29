//
//  Flag.h
//  03-NationalFlag
//
//  Created by Aixtuz Kang on 15/6/16.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flag : NSObject

// 名称
@property (copy, nonatomic) NSString *name;
// 国旗
@property (copy, nonatomic) NSString *icon;

// 初始化方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)flagWithDict:(NSDictionary *)dict;

@end
