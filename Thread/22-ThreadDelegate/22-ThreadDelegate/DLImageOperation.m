//
//  DLImageOperation.m
//  22-ThreadDelegate
//
//  Created by Aixtuz Kang on 15/7/18.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "DLImageOperation.h"

@implementation DLImageOperation

//!!!: Start/操作加入队列, 自动执行main方法;
- (void)main {
    // 子线程无法访问主线程自动释放池,需手动建
    @autoreleasepool {
        
        // 下载图片
        self.img = [self downloadOImage];
        
        // 主线程刷新UI, 代理方法存在, 则调用
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(setUpImageWithOperation:)]) {
                [self.delegate setUpImageWithOperation:self];
            }
        });
    }
}

// 下载图片方法
- (UIImage *)downloadOImage {
    
    NSString *urlString = @"http://f10.topitme.com/o/201101/28/12962103503636.jpg";
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}

@end
