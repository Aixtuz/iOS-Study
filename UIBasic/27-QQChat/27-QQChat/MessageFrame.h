//
//  AppDelegate.h
//  27-QQChat
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

// 文本字体
#define textFont [UIFont systemFontOfSize:15]
// 内边距
#define textPadding 20

@interface MessageFrame : NSObject 

// 控件的Frame
@property (assign, nonatomic, readonly) CGRect timeF;
@property (assign, nonatomic, readonly) CGRect iconF;
@property (assign, nonatomic, readonly) CGRect textF;

// 行高
@property (assign, nonatomic, readonly) CGFloat rowHeight;

// 模型属性
@property (strong, nonatomic) Message *message;

// 时间是否隐藏
@property (assign, nonatomic, getter=isHideTime) BOOL hideTime;

@end
