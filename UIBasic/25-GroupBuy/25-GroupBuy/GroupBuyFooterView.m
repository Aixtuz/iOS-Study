//
//  GroupBuyFooterView.m
//  25-GroupBuy
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "GroupBuyFooterView.h"

@interface GroupBuyFooterView ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadView;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UIButton *btnView;

@end

@implementation GroupBuyFooterView

// 加载footerView的方法
+ (instancetype) GroupBuyFooterView {
    
    // 提供给他人加载此Xib的方法,注意:loadNibNamed: 返回数组
    return [[[NSBundle mainBundle] loadNibNamed:@"GroupBuyFooterView" owner:nil options:nil] firstObject];
}

// 停止加载的方法
- (void) stopLoading {
    
    // 菊花停转
    [self.loadView stopAnimating];
    // 按钮显示
    self.btnView.hidden = NO;
}

// 监听按钮
- (IBAction)load {
    
    // 处理控件显示隐藏
    self.btnView.hidden = YES;
    
    // 菊花开转
    [self.loadView startAnimating];
    
    // 如果协议声明的加载数据方法已被代理实现，则加载数据；
    if ([self.delegate respondsToSelector:@selector(loadWithFooterView:)]) {
        [self.delegate loadWithFooterView:self];
    }
}

@end
