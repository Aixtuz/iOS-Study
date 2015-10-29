//
//  MicroBlogFrame.h
//  26-MicroBlog
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MicroBlog.h"

@interface MicroBlogFrame : NSObject

// 图标frame
@property (nonatomic, assign,readonly) CGRect iconF;
// 昵称frame
@property (nonatomic, assign,readonly) CGRect nameF;
// vipframe
@property (nonatomic, assign,readonly) CGRect vipF;
// 文本frame
@property (nonatomic, assign,readonly) CGRect textF;
// 图片frame
@property (nonatomic, assign,readonly) CGRect picF;

// 行高
@property (nonatomic, assign,readonly) CGFloat rowHeight;

// 数据模型
@property (nonatomic, strong)   MicroBlog *microBlog;

@end
