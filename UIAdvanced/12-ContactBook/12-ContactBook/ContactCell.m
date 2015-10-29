//
//  ContactCell.m
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/23.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ContactCell.h"
#import "Contact.h"

@implementation ContactCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

// 封装初始化Cell方法(缓冲池出列 + 重新加载)
+ (instancetype)contactCellWithTableView:(UITableView *)tableView{
    
    // 根据ID缓冲池出列复用
    NSString *reuseId = @"ID";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    // 不存在则创建
    if (cell == nil) {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    // 设置右侧图标类型
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// 重写setter方法,实现contact的解析赋值;
-(void)setContact:(Contact *)contact {
    
    // 先赋值属性,用于getter数据一致;
    _contact = contact;
    
    // 解析赋值
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.phone;
}

@end
