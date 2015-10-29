//
//  AppDelegate.h
//  27-QQChat
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Message.h"

@implementation Message

// 重写构造方法,封装字典转模型;

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

// 加载plist方法
+ (NSArray *)messages {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dictArray.count];
    for (NSDictionary *dict in dictArray) {
        Message *message = [[self alloc] initWithDict:dict];
        [arrayM addObject:message];
    }
    return arrayM;
}


@end
