//
//  AppView.m
//  17-AppMgrXibOpt
//
//  Created by Aixtuz Kang on 15/5/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AppView.h"

// 延展类
@interface AppView()

// 声明两个私有变量,表示icon和name
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end


@implementation AppView

- (void)setAppModel:(AppModel *)appModel{
    
    //!!!: 定义模型属性做接口,接收模型封装的数据,解析模型赋值控件对应私有属性,还需赋值给模型属性,以便刷新数据时,getter去模型属性数据无误;
    _appModel = appModel;
    
    // AppModel对象赋予appMdel，再用属性赋值
    //!!!: 解析数据模型,赋值控件对应私有属性
    self.icon.image = [UIImage imageNamed:appModel.icon];
    self.name.text = appModel.name;
   
}

@end
