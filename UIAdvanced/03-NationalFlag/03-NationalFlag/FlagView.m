//
//  FlagView.m
//  03-NationalFlag
//
//  Created by Aixtuz Kang on 15/6/16.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "FlagView.h"

@interface FlagView ()

// 名称控件
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 国旗控件
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation FlagView

// 返回行高方法
+ (CGFloat)rowHeight {
    return 100;
}

// 封装加载方法
+ (instancetype)flagViewWithView:(UIView *)view{
    // 如果存在则复用
    FlagView *flagView = (FlagView *)view;
    if (flagView == nil) {
        flagView = [[[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil] firstObject];
    }
    return flagView;
}

// 重写setter方法
- (void)setFlag:(Flag *)flag {
    _flag = flag;
    self.nameLabel.text = flag.name;
    self.iconView.image = [UIImage imageNamed:flag.icon];
}

@end
