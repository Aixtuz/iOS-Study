//
//  OneViewController.m
//  15-TabBarController
//
//  Created by Aixtuz Kang on 15/6/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 可以在viewDidLoad中设置当前Controller内容，也可在代理中监听didFinishLaunching中设置;
//    // 按钮的标题,图片,和通知数
//    self.tabBarItem.title = @"联系人";
//    self.tabBarItem.image = [UIImage imageNamed:@"tab_buddy_nor"];
//    self.tabBarItem.badgeValue = @"10";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
