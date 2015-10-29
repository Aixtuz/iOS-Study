//
//  Student.h
//  14-DataIO
//
//  Created by Aixtuz Kang on 15/6/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Person.h"

// 继承, 已遵守协议
@interface Student : Person

// 学号
@property (nonatomic, copy) NSString *stuNO;

@end
