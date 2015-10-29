//
//  AppDelegate.h
//  27-QQChat
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "UIImage+KCL.h"

@implementation UIImage (KCL)

// 传入图片名,返回可拉伸图片
+ (instancetype)resizableImageNamed:(NSString *)imageName {
    
    // 加载图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 计算拉伸位置
    CGFloat left = image.size.width * 0.5;
    CGFloat top = image.size.height * 0.5;
    CGFloat right = left;
    CGFloat bottom = top;
    
    // 返回可拉伸图片
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
}

@end
