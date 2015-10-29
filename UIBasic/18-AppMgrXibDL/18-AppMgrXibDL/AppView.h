//
//  AppView.h
//  18-AppMgrXibDL
//
//  Created by Aixtuz Kang on 15/5/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"

@interface AppView : UIView

//!!!: 拥有一个模型属性，用于接收传入模型的属性值
@property (strong, nonatomic) AppModel *appModel;

//!!!: 封装loadNibNamed:方法
+ (instancetype)loadView;

@end
