//
//  PhotoView.h
//  34-DrawingBoard
//
//  Created by Aixtuz Kang on 15/7/4.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoView;

// 定义协议
@protocol PhotoViewDelegate <NSObject>

- (void)photoView:(PhotoView *)photoView image:(UIImage *)image;

@end

@interface PhotoView : UIView

// 代理对象
@property (nonatomic, weak) id<PhotoViewDelegate> delegate;

// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame photo:(UIImage *)image;
+ (instancetype)photoViewWithFrame:(CGRect)frame photo:(UIImage *)image;

@end
