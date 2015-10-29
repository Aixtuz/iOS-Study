//
//  DLImageOperation.m
//  25-SDWebImage4AppList
//
//  Created by Aixtuz Kang on 15/7/20.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "DLImageOperation.h"
#import "ReadAndWriteSandBox.h"

@interface DLImageOperation ()

// 读写功能对象的属性
@property (nonatomic, strong) ReadAndWriteSandBox *sandbox;

@end

@implementation DLImageOperation

// 传递用于设置图片的blk的方法
- (void)setImageWithBlock:(myBlock)blk {
    
    // 定义了blk内容, 则传给self.blk
    if (blk) {
        self.blk = blk;
    }
}

//!!!: 操作Start或加入队列, 则执行op的main方法
- (void)main {
    
    //!!!: 子线程无法访问主线程的自动释放池,需手动新建
    @autoreleasepool {
        
        // 下载图片赋予属性
        self.img = [self downloadImageWithUrlString:self.urlStr];
        
        // block加入主队列,实现主线程刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (self.blk) {
                // 传入op自身
                self.blk(self);
            }
        }];
    }
}

// 下载图片方法
- (UIImage *)downloadImageWithUrlString:(NSString *)urlStr {
    
    // 下载
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 定义图片存储位置(Caches)
    [data writeToFile:[self.sandbox getSandboxCachesByFilename:urlStr] atomically:YES];
    
    // 设置图片
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}

// 懒加载
- (ReadAndWriteSandBox *)sandbox {
    if (_sandbox == nil) {
        _sandbox = [[ReadAndWriteSandBox alloc] init];
    }
    return  _sandbox;
}

@end

