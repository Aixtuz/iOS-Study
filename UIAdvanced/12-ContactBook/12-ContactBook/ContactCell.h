//
//  ContactCell.h
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/23.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@interface ContactCell : UITableViewCell

// 接收模型数据
@property (strong, nonatomic) Contact *contact;

//!!!: 封装初始化Cell方法(缓冲池出列 + 重新加载)
//!!!: 初始化方法勿忘返回instancetype类型,方便子类调用此方法;
+ (instancetype)contactCellWithTableView:(UITableView *)tableView;

@end

