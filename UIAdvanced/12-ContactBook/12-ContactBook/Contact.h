//
//  Contact.h
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/22.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject <NSCoding>

// 姓名
@property (copy, nonatomic) NSString *name;
// 电话
@property (copy, nonatomic) NSString *phone;
//!!!: copy用weak的话,会导致模型中的属性提前释放;

@end
