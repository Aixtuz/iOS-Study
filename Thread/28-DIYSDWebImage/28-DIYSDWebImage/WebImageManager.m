//
//  WebImageManager.m
//  28-DIYSDWebImage
//
//  Created by Aixtuz Kang on 15/7/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "WebImageManager.h"

@interface WebImageManager ()

// 队列属性
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation WebImageManager

// 获取单例的方法
+ (instancetype)shareWebImageManager {
    
    // 定义静态变量保存单例
    static id _instance;
    
    // 用一次性代码实现单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

// 获取图片的方法
- (void)getImage:(NSString *)urlStr withBlock:(getImageBlock)blk {
    
    // 创建操作
    DownloadOperation *op = [[DownloadOperation alloc] init];
    
    // 为操作赋值要下载的url
    op.urlStr = urlStr;
    
    // 传递block设置图片
    [op setImageWithBlock:^(DownloadOperation *op){
        if (op.image) {
            
            // 执行blk
            blk(op.image);
        }
    }];
    [self.queue addOperation:op];
}

// 懒加载queue
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:5];
    }
    return _queue;
}

@end
