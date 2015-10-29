//
//  Province.h
//  02-CitySelect
//
//  Created by Aixtuz Kang on 15/6/15.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

// 省
@property (copy, nonatomic) NSString *name;
// 市
@property (strong, nonatomic) NSArray *cities;

// 初始化方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)provinceWithDict:(NSDictionary *)dict;

@end
