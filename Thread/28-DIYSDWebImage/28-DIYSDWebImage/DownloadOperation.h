//
//  DownloadOperation.h
//  28-DIYSDWebImage
//
//  Created by Aixtuz Kang on 15/7/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DownloadOperation;

// 定义Block
typedef void(^setImageBlock)(DownloadOperation *op);

@interface DownloadOperation : NSOperation

// url
@property (nonatomic, copy) NSString *urlStr;

// 图片
@property (nonatomic, strong) UIImage *image;

// 图片下载后, 以block设置图片
@property (nonatomic, copy) setImageBlock blk;

// 传递block设置图片的方法
- (void)setImageWithBlock:(setImageBlock)blk;

@end
