//
//  AppModel.h
//  18-AppMgrXibDL
//
//  Created by Aixtuz Kang on 15/5/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *name;

// 重写构造方法实现封装字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict;

// 类方法一般用类名开头
+ (instancetype)appModelWithDict:(NSDictionary *)dict;


@end
