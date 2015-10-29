//
//  AppDelegate.h
//  27-QQChat
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MessageFrame.h"
#import "NSString+KCL.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message {
    
    //  1.给本方法对应的成员变量赋值
    _message = message;
    
    //  2.计算frame和行高
    
    // 获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 10;
    
    // 计算时间标签的frame
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 18;
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 计算头像frame
    CGFloat iconW = 45;
    CGFloat iconH = iconW;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconX = 0;
    if (message.type == MessageTypeMe) {
        iconX = screenW - margin - iconW;
    } else if (message.type == MessageTypeOther) {
        iconX = margin;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);

    //!!!: 计算文本的size
    // 文本最大宽度
    CGFloat textMaxW = screenW - iconW - margin * 3 - 2 * textPadding;
    
    //!!!: 计算文本区域方法,封装再NSString延展中(引用头文件);
    /*
    // 计算文本的最大区域
    CGSize textMaxSize = CGSizeMake(textMaxW, CGFLOAT_MAX);
    
    // 计算文本使用字体
    NSDictionary *attr = @{NSFontAttributeName:textFont};
    
    // 文本实际大小
    CGSize textSize = [message.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    */
    
    // 直接用延展返回文本区域大小;
    CGSize textSize = [message.text sizeWithMaxWidth:textMaxW andFont:textFont];
    // 计算frame
    CGFloat textBtnW = textSize.width + 2 * textPadding;
    CGFloat textBtnH = textSize.height + 2 * textPadding;
    CGFloat textBtnY = iconY;
    CGFloat textBtnX = 0;
    // 判断type
    if (message.type == MessageTypeMe) {
        // 我: 靠右
        textBtnX = iconX - margin - textBtnW;
    } else if (message.type == MessageTypeOther) {
        //她: 靠左
        textBtnX = iconW + 2 * margin;
    }
    // 设置frame
    _textF = CGRectMake(textBtnX, textBtnY, textBtnW, textBtnH);
    
    //!!!: 计算行高
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    _rowHeight = (iconMaxY > textMaxY ? iconMaxY : textMaxY) + margin;
    // _rowHeight = 100;
}

@end
