//
//  EditController.h
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/23.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditController, Contact;

@protocol EditControllerDelegate <NSObject>

- (void)editController:(EditController *)ec;

@end


@interface EditController : UIViewController

// 模型属性,接收数据
@property (nonatomic, strong) Contact *contact;
// 代理属性
@property (nonatomic, weak) id<EditControllerDelegate> delegate;

@end
