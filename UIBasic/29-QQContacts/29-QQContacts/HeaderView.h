//
//  HeaderView.h
//  29-QQContacts
//
//  Created by Aixtuz Kang on 15/6/14.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactGroup.h"

@interface HeaderView : UITableViewHeaderFooterView

// 对外接收模型,解析赋值
@property (strong, nonatomic) ContactGroup *contactGroup;

@end
