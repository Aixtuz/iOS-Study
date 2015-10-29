//
//  MessageCell.h
//  05-QQChat
//
//  Created by Aixtuz Kang on 15/6/8.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageFrame.h"

@interface MessageCell : UITableViewCell

@property (strong, nonatomic) MessageFrame *messageFrame;

// 缓冲池出列 + 重写初始化方法 封装为 加载Cell的方法
+ (instancetype)messageCellWithTableView:(UITableView *)tableView;

@end
