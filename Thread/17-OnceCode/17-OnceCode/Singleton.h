//
//  Singleton.h
//  17-OnceCode
//
//  Created by Aixtuz Kang on 15/7/16.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

// 获取单例对象的方法
+ (instancetype)shareSingleton;

@end
