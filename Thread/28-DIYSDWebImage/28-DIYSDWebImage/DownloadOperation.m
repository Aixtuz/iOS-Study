//
//  DownloadOperation.m
//  28-DIYSDWebImage
//
//  Created by Aixtuz Kang on 15/7/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation

// 操作start或加入队列，执行main方法
-(void)main {
    @autoreleasepool {
        // 下载图片
        self.image = [self downloadImageWithUrl:self.urlStr];
        
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.blk) {
                self.blk(self);
            }
        });
    }
}
                      
// 下载图片方法
- (UIImage *)downloadImageWithUrl:(NSString *)urlStr {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

// 传递block设置图片的方法
- (void)setImageWithBlock:(setImageBlock)blk {
    if (blk) {
        self.blk = blk;
    }
}

@end
