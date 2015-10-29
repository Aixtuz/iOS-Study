//
//  MicroBlogFrame.m
//  26-MicroBlog
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MicroBlogFrame.h"

#define nameFont [UIFont systemFontOfSize:18]
#define textFont [UIFont systemFontOfSize:14]

@implementation MicroBlogFrame

// 重写数据模型setter方法
- (void)setMicroBlog:(MicroBlog *)microBlog {
    
    //  0.先给cell拥有的模型属性赋值
    _microBlog = microBlog;
    
    CGFloat margin = 10;
    
    // 头像
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    
    // 设置frame封装进frame模型，用protect属性存储frame参数，以供调用；
    // self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    //!!!: 只读属性不能通过getter方法调用，只能通过下划线直接访问；（下同）
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    // 计算一行文本的大小的方法
    NSDictionary *attr = @{NSFontAttributeName:nameFont};
    CGSize nameSize = [microBlog.name sizeWithAttributes:attr];
    
    // icon的frame的x坐标最大值 + margin
    CGFloat nameX = CGRectGetMaxX(self.iconF) + margin;
    CGFloat nameY = margin + (iconH - nameSize.height) * 0.5;
    
    //!!!: CGSize作为整体设置frame的方法
    _nameF= (CGRect){nameX, nameY, nameSize};
    
    // VIP
    CGSize vipSize = [UIImage imageNamed:@"vip"].size;
    CGFloat vipX = CGRectGetMaxX(self.nameF) + margin;
    CGFloat vipY = margin + (iconH - vipSize.height) * 0.5;
    _vipF = (CGRect){vipX, vipY, vipSize};
    
    // 文本
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconF) + margin;
    
    // 屏幕单例对象，可知屏幕宽度
    CGFloat screenW  = [UIScreen mainScreen].bounds.size.width;
    CGFloat textMaxW = screenW - margin * 2;
    
    // 计算文本的时候,文本能绘制最大区域
    CGSize textMaxSize = CGSizeMake(textMaxW, CGFLOAT_MAX);
    NSDictionary *textAttr = @{NSFontAttributeName: textFont};
    
    // 字体所占用实际大小
    CGSize textSize = [microBlog.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil].size;
    _textF =  (CGRect){textX,textY,textSize};
    
    // 图片(有，才加载)
    if (microBlog.pic) {
        CGFloat pictureX = iconX;
        CGFloat pictureY = CGRectGetMaxY(self.textF) + margin;
        CGFloat pictureW = 100;
        CGFloat pictureH = 100;
        _picF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
    }
    
    // 计算行高
    _rowHeight = CGRectGetMaxY(self.textF) + margin;
    if (microBlog.pic) {
        _rowHeight = CGRectGetMaxY(self.picF) + margin;
    }
    //!!!: 算出的行高是否正常：NSLog(@"行高%f", rowHeight);
}

@end
