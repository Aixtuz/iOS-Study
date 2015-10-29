//
//  UnlockView.h
//  35-GestureUnlock
//
//  Created by Aixtuz Kang on 15/7/5.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UnlockView;

// 定义代理协议(协议,属性定义完,令VC遵守协议,实现代理方法)
@protocol UnlockViewDelegate <NSObject>

// 验证密码方法
- (BOOL)unlockView:(UnlockView *)unlockView withPwd:(NSString *)pwd;

@end

@interface UnlockView : UIView

// 代理属性
@property (nonatomic, weak) id<UnlockViewDelegate> delegate;

@end
