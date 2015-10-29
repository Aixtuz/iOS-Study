//
//  GroupBuyCell.h
//  25-GroupBuy
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
// @class引用,实际使用时仍需#import
@class GroupBuy;

@interface GroupBuyCell : UITableViewCell

// GroupBuy模型对象(OC对象,Strong)，唯一接收数据的接口,
@property (strong, nonatomic) GroupBuy *groupBuy;

// 声明并实现创建Cell的方法(传入参数用于对应缓冲池出列), 其中包含Xib: Cell的加载过程;
+ (UITableViewCell *)groupBuyWithTableView:(UITableView *)tableView;

@end