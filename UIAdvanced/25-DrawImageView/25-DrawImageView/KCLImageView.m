//
//  KCLImageView.m
//  25-DrawImageView
//
//  Created by Aixtuz Kang on 15/6/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "KCLImageView.h"

@implementation KCLImageView

// 重写setter方法,接收image
- (void)setImage:(UIImage *)image {
    
    // 先赋予属性
    _image = image;
    // 刷新显示
    //!!!: 不要错写成setNeedsLayout
    [self setNeedsDisplay];
}

// 绘图方法
- (void)drawRect:(CGRect)rect {
    
    // 绘制图片,在view中;
    [self.image drawInRect:rect];
}


@end
