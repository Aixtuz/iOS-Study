//
//  DLImageOperation.m
//  23-ThreadBlock
//
//  Created by Aixtuz Kang on 15/7/19.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "DLImageOperation.h"

@implementation DLImageOperation

// 设置block执行的代码块
- (void)setUpImageWithBlock:(myBlock)blk {
    
    // blk存在则设置代码块
    if (blk) {
        
        // myBlock接收blk中内容
        self.myBlock = blk;
    }
}

// start/操作入队列,自动执行main方法
- (void)main {
    
    // 子线程无法访问主线程自动释放池,需自建
    @autoreleasepool {
        
        // 下载图片
        self.img = [self downloadImage];
        
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // block存在则执行
            if (self.myBlock) {
                self.myBlock(self.img);
            }
        });
    }
}

// 下载图片方法
- (UIImage *)downloadImage {
    
    // 检测取消下载
    if (self.isCancelled) {
        return nil;
    }
    
    // 获取url
    NSString *urlStr = @"http://f10.topitme.com/o/201101/28/12962103503636.jpg";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 检测取消下载
    if (self.isCancelled) {
        return nil;
    }
    
    // 开始下载
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 检测取消下载
    if (self.isCancelled) {
        return nil;
    }
    
    // 图片赋值
    UIImage *img = [UIImage imageWithData:data];
    NSLog(@"%@", img);
    return img;
}

@end
