//
//  AppDelegate.h
//  27-QQChat
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (KCL)

// 计算文本区域大小,必定有NSString对象,才能计算
//!!!: CGSize,CGRect需要UIKit头文件;
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont *)font;

@end
