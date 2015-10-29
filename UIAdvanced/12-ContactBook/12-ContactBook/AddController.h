//
//  AddController.h
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/22.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>

//!!!: 代理需要取得AC中的模型,则需引用AC&&模型;
@class AddController, Contact;

//!!!: 代理协议功能: 取得AC中封装数据的模型, 将模型加入模型数组,刷新Cell数据;
@protocol addControllerDelegate <NSObject>

// 代理协议中方法,定是对象方法,由代理调用;
- (void)addController:(AddController *)ac withContact:(Contact *)contact;

@end

@interface AddController : UIViewController

// 定义代理属性
@property (weak, nonatomic) id<addControllerDelegate> delegate;

@end
