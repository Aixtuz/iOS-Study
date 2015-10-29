//
//  Contact.m
//  29-QQContacts
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Contact.h"

@implementation Contact

// 初始化方法
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

// 类方法初始化
+ (instancetype)contactWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
