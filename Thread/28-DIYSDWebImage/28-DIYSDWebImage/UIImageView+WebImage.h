//
//  UIImageView+WebImage.h
//  28-DIYSDWebImage
//
//  Created by Aixtuz Kang on 15/7/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

// 异步下载图片的方法
- (void)setImageWithUrlString:(NSString *)urlStr;

@end
