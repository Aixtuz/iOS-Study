//
//  MicroBlogViewCell.h
//  26-MicroBlog
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MicroBlog.h"
#import "MicroBlogFrame.h"

@interface MicroBlogViewCell : UITableViewCell

// 模型属性，对外接口，接收数据
@property (strong, nonatomic) MicroBlog *microBlog;

// frame模型
@property (nonatomic, strong) MicroBlogFrame *microBlogFrame;

// (缓冲池出列 + 加载新Cell)封装为构造方法
//!!!: 重写构造方法，记得用instancetype返回类型
+ (instancetype)microBlogWithTableView:(UITableView *)tableView;

@end
