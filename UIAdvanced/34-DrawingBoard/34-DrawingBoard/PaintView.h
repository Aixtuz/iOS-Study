//
//  PaintView.h
//  34-DrawingBoard
//
//  Created by Aixtuz Kang on 15/7/1.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintView : UIView

// 接收传入的线宽参数
@property (nonatomic, assign) float lineWidth;

// 接收传来的颜色参数
@property (nonatomic, strong) UIColor *lineColor;

// 接收传来的图片
@property (nonatomic, strong) UIImage *photo;

// 清空
- (void)clearScreen;

// 后退
- (void)backward;

// 橡皮
- (void)erase;


@end
