//
//  GroupBuy.h
//  25-GroupBuy
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuy : NSObject

// 图标
@property (copy, nonatomic) NSString *icon;
// 标题
@property (copy, nonatomic) NSString *title;
// 价格
@property (copy, nonatomic) NSString *price;
// 销售量
@property (copy, nonatomic) NSString *buyCount;

// 重写构造方法，字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupBuyWithDict:(NSDictionary *)dict;

// 装载plist
+ (NSMutableArray *)groupBuys;

@end
