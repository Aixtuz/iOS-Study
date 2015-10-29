
//
//  GroupBuyCell.m
//  25-GroupBuy
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "GroupBuyCell.h"
#import "GroupBuy.h"

// 有模型属性做接口，接受数据，内部解析赋值子控件属性可私有
@interface GroupBuyCell ()

// 图标控件
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
// 标题控件
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 价格控件
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
// 销售量控件
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end


@implementation GroupBuyCell

// 重写其模型属性的setter方法
- (void)setGroupBuy:(GroupBuy *)groupBuy {
    
    // 先将传入的模型数据 赋予 自身的模型属性，保持getter方法取值 和 下述子控件的赋值一致
    _groupBuy = groupBuy;
    
    // 子控件赋值
    self.iconView.image = [UIImage imageNamed:groupBuy.icon];
    self.titleLabel.text = groupBuy.title;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元", groupBuy.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"已售%@", groupBuy.buyCount];
}

// 声明并实现创建Cell的方法(传入参数用于对应缓冲池出列), 其中包含Xib: Cell的加载过程;
+ (UITableViewCell *)groupBuyWithTableView:(UITableView *)tableView {
    
    // 定义标识符
    NSString *reuseId = @"cell";
    // 根据标识符出列
    GroupBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    //
    if (cell == nil) {
        //!!!: loadNibNamed: 方法返回的是Xib内view的数组,Xib只含一个View时,可用firstObject\lastObject;
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupBuyCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

@end

