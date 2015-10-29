//
//  KCLFiveDirectionPad.m
//  07-FiveDirectionPad
//
//  Created by Aixtuz Kang on 15/7/11.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "KCLFiveDirectionPad.h"

@implementation KCLFiveDirectionPad

// 返回九宫格View的方法
+ (UIView *)fiveDicrectionPadView:(UIView *)view withRows:(int)rows andCols:(int)cols andMargin:(CGFloat)margin byImageUrls:(NSArray *)array {
    
    // 九宫格布局view区域
    CGFloat viewWidth = view.bounds.size.width;
    
    // 计算格子大小
    CGFloat imageW = (viewWidth - margin * (cols - 1)) / cols;
    CGFloat imageH = imageW;
    
    // 遍历布局frame
    for (int i = 0; i < rows * cols; i++) {
        
        // 计算当前索引所在行列
        int row = i / cols;
        int col = i % cols;
        
        // 计算图片位置
        CGFloat imageX = (imageW + margin) * col;
        CGFloat imageY = (imageH + margin) * row;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageW)];
        
        imageView.backgroundColor = [UIColor greenColor];
        
        // 设置归属
        [view addSubview:imageView];
        
        // 子线程下载图片 + 主线程刷新UI
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            // 子线程下载图片
            NSURL *url = [NSURL URLWithString:array[i % array.count]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            //TODO: 更换下载链接,搞定图片下载
            NSLog(@"正在下载第%d张: %@", i + 1, image);
            
            // 主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        });
    }
    return view;
}

@end
