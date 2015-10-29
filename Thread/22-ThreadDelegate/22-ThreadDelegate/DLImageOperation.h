//
//  DLImageOperation.h
//  22-ThreadDelegate
//
//  Created by Aixtuz Kang on 15/7/18.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DLImageOperation;

@protocol DLImageOperationDelegate <NSObject>

@optional
// 代理方法
- (void)setUpImageWithOperation:(DLImageOperation *)op;

@end

@interface DLImageOperation : NSOperation

// 图片
@property (nonatomic, strong) UIImage *img;

// 代理: ARC下用weak, MRC下用assign
@property (nonatomic, weak) id<DLImageOperationDelegate> delegate;

@end
