//
//  AppModel.h
//  13-AppMgrDict2Model
//
//  Created by Aixtuz Kang on 15/5/26.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

//!!!: 模型属性 接收 字典键值
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *name;

@end
