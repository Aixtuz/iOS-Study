//
//  AppDelegate.h
//  27-QQChat
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MessageTypeMe,
    MessageTypeOther
} MessageType;

@interface Message : NSObject

// 消息类型
@property (assign, nonatomic) MessageType type;
// 消息时间
@property (copy, nonatomic) NSString *time;
// 消息内容
@property (copy, nonatomic) NSString *text;

// 重写构造方法,封装字典转模型;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;

// 加载plist方法
+ (NSArray *)messages;


@end
