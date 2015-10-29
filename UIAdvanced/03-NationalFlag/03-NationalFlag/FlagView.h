//
//  FlagView.h
//  03-NationalFlag
//
//  Created by Aixtuz Kang on 15/6/16.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flag.h"

@interface FlagView : UIView

// 模型做数据接口
@property (strong, nonatomic) Flag *flag;

// 返回行高方法
+ (CGFloat)rowHeight;

// 封装加载方法
+ (instancetype)flagViewWithView:(UIView *)view;

@end
