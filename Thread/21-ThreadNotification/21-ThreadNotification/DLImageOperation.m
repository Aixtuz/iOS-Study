//
//  DLImageOperation.m
//  21-ThreadNotification
//
//  Created by Aixtuz Kang on 15/7/18.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "DLImageOperation.h"

@implementation DLImageOperation

//!!!: Start或操作加入队列后,会自动执行main方法
- (void)main {
    
    //!!!: 子线程对象,无法访问主线程自动释放池,需手动建立
    @autoreleasepool {
        
        // 下载图片
        self.img = [self downloadImage];
        
        // 在主线程发送通知
        dispatch_async(dispatch_get_main_queue(), ^{
            // 将操作本身作为参数传递
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DLImageOperation" object:self];
        });
    }
}

// 下载图片方法
- (UIImage *)downloadImage {
    
    // 下载图片
    NSString *urlString = @"http://f10.topitme.com/o/201101/28/12962103503636.jpg";
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}

@end

