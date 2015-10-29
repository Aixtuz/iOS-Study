//
//  PopViewController.h
//  18-Modal4Controller
//
//  Created by Aixtuz Kang on 15/6/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopViewController;

// 代理协议,用于将DC做代理,关闭PC
@protocol PopViewControllerDelegate <NSObject>

- (void)pcDidCloseBtn:(PopViewController *)pc;

@end

@interface PopViewController : UIViewController

// 代理属性
@property (nonatomic, weak) id<PopViewControllerDelegate> delegate;

@end
