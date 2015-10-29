//
//  GroupBuyFooterView.h
//  25-GroupBuy
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>

// 声明类存在
@class GroupBuyFooterView;

@protocol GroupBuyFooterViewDelegate <NSObject>

// 可选实现方法
@optional
- (void) loadWithFooterView:(GroupBuyFooterView *) footerView;

@end

@interface GroupBuyFooterView : UIView

// 代理用weak，避免循环引用
@property (weak, nonatomic) id <GroupBuyFooterViewDelegate> delegate;

// 加载footerView的方法
+ (instancetype) GroupBuyFooterView;

// 停止加载的方法
- (void) stopLoading;

@end
