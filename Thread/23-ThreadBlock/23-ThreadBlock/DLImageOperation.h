//
//  DLImageOperation.h
//  23-ThreadBlock
//
//  Created by Aixtuz Kang on 15/7/19.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 定义block类型
typedef void(^myBlock)(UIImage *img);

@interface DLImageOperation : NSOperation

// 图片
@property (nonatomic, strong) UIImage *img;
// block
@property (nonatomic, copy) myBlock myBlock;

// 设置block执行的代码块
- (void)setUpImageWithBlock:(myBlock)blk;

@end
