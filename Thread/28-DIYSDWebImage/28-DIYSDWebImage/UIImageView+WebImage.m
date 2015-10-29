//
//  UIImageView+WebImage.m
//  28-DIYSDWebImage
//
//  Created by Aixtuz Kang on 15/7/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import "WebImageManager.h"

@implementation UIImageView (WebImage)

// 异步下载图片的方法
- (void)setImageWithUrlString:(NSString *)urlStr {
    
    // 实例化一个下载管理类
    WebImageManager *mgr = [WebImageManager shareWebImageManager];
    
    // self,block循环引用
    __weak typeof(self) weakSelf = self;
    [mgr getImage:urlStr withBlock:^(UIImage *image) {
        weakSelf.image = image;
    }];
}

@end
