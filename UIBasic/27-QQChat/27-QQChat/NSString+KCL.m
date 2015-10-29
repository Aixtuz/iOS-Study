//
//  AppDelegate.h
//  27-QQChat
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "NSString+KCL.h"

@implementation NSString (KCL)

// 计算文本区域大小,必定有NSString对象,才能计算
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont *)font {

    // 计算文本的最大区域
    CGSize textMaxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    // 计算文本使用字体
    NSDictionary *attr = @{NSFontAttributeName:font};
    
    // 文本实际大小
    return [self boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
