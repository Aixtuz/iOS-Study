//
//  AppModel.h
//  15-AppMgrD2MOpt
//
//  Created by Aixtuz Kang on 15/5/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *name;

// 重写构造方法实现封装字典转模型
- (id)initWithDict:(NSDictionary *)dict;

// 类方法一般以类名开头
+ (id)appModelWithDict:(NSDictionary *)dict;

@end
