//
//  WebImageManager.h
//  28-DIYSDWebImage
//
//  Created by Aixtuz Kang on 15/7/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownloadOperation.h"

// 定义Block类型
typedef void(^getImageBlock)(UIImage *image);

// 下载的工具类(单例)
@interface WebImageManager : NSObject

// Block属性
@property (nonatomic, copy) getImageBlock blk;

// 获取单例的方法
+ (instancetype)shareWebImageManager;

// 获取图片的方法
- (void)getImage:(NSString *)urlStr withBlock:(getImageBlock)blk;

@end
