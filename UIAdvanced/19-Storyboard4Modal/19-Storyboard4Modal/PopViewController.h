//
//  PopViewController.h
//  19-Storyboard4Modal
//
//  Created by Aixtuz Kang on 15/6/26.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopViewController;

// 由VC设置str,故VC做PC代理,来获取数据;
// 代理协议
@protocol PopViewControllerDelegate <NSObject>

// 关闭PC且让VC设置str的方法,代理方法要把自己传进去
- (void)closePC:(PopViewController *)pc withTitiel:(NSString *)str;

@end

@interface PopViewController : UIViewController

// 定义代理属性
@property (nonatomic, weak) id<PopViewControllerDelegate> delegate;

@end
