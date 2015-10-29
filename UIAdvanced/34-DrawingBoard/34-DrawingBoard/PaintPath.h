//
//  PaintPath.h
//  34-DrawingBoard
//
//  Created by Aixtuz Kang on 15/7/2.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintPath : UIBezierPath

// 每个path定义各自lineColor
@property (nonatomic, strong) UIColor *pathLineColor;

@property (nonatomic, strong) UIImage *image;

@end
