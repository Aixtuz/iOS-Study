//
//  DLImageOperation.h
//  25-SDWebImage4AppList
//
//  Created by Aixtuz Kang on 15/7/20.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DLImageOperation;

// 定义op参数的block类型
typedef void(^myBlock)(DLImageOperation *op);

@interface DLImageOperation : NSOperation

// 传入操作的图片的地址
@property (nonatomic, copy) NSString *urlStr;

// 操作中下载的图片
@property (nonatomic, strong) UIImage *img;

//!!!: block属性不带*号
@property (nonatomic, copy) myBlock blk;

// 传递用于设置图片的blk的方法
- (void)setImageWithBlock:(myBlock)blk;

@end
