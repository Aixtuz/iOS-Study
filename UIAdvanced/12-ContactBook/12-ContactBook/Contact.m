//
//  Contact.m
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/22.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "Contact.h"

@implementation Contact

//!!!:  定义对象的存取方法, 需遵守NSCoding协议

// 存
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    // 存储格式
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
}

// 取
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}

@end
