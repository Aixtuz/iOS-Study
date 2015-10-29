//
//  HeaderView.m
//  29-QQContacts
//
//  Created by Aixtuz Kang on 15/6/14.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (weak, nonatomic) UIButton *headerBtn;
@property (weak, nonatomic) UILabel *onlineLabel;

@end


@implementation HeaderView

// 重写初始化方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        // 设置控件
        UIButton *headerBtn = [[UIButton alloc] init];
        [self.contentView addSubview:headerBtn];
        self.headerBtn = headerBtn;
        
        UILabel *onlineLabel = [[UILabel alloc] init];
        [self.contentView addSubview:onlineLabel];
        self.onlineLabel = onlineLabel;
        
        // 只需设置一次的代码(背景\图标\颜色\对齐\边距\frame\绑定点击事件)
        // 背景
        [headerBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [headerBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 图标
        [headerBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        // 颜色
        [headerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 对齐
        headerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        onlineLabel.textAlignment = NSTextAlignmentRight;
        // 内边距
        headerBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        headerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
        // 添加按钮的点击事件
        [headerBtn addTarget:self action:@selector(headerTouched) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// 布局子控件
- (void)layoutSubviews {
    // //!!!: 必须先调用此方法
    [super layoutSubviews];
    self.headerBtn.frame = self.bounds;
    CGFloat onlineW = 150;
    CGFloat onlineH = self.bounds.size.height;
    CGFloat onlineY = 0;
    CGFloat onlineX = self.bounds.size.width - onlineW - 20;
    
    self.onlineLabel.frame = CGRectMake(onlineX, onlineY, onlineW, onlineH);
}

- (void) headerTouched
{
    NSLog(@"%s",__func__);
}

- (void)setContactGroup:(ContactGroup *)contactGroup {
    _contactGroup = contactGroup;
    [self.headerBtn setTitle:contactGroup.name forState:UIControlStateNormal];
    self.textLabel.text = [NSString stringWithFormat:@"%d/%ld", contactGroup.online, contactGroup.contacts.count];
}


@end

