//
//  KCLFiveDirectionPad.h
//  07-FiveDirectionPad
//
//  Created by Aixtuz Kang on 15/7/11.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCLFiveDirectionPad : NSObject

// 返回九宫格View的方法
+ (UIView *)fiveDicrectionPadView:(UIView *)view withRows:(int)rows andCols:(int)cols andMargin:(CGFloat)margin byImageUrls:(NSArray *)array;

@end
