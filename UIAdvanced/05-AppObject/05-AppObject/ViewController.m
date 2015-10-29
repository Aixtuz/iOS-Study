//
//  ViewController.m
//  05-AppObject
//
//  Created by Aixtuz Kang on 15/6/19.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //!!!: App单例对象
//    UIApplication *app1 = [UIApplication sharedApplication];
//    UIApplication *app2 = [UIApplication sharedApplication];
//    NSLog(@"\n%@\n%@", app1, app2);
}

- (IBAction)btnClick:(UIButton *)sender {
    
    // 获取UIApplication单例对象
    UIApplication *app = [UIApplication sharedApplication];
    
    //!!!: ios8 设置通知 必须用户许可
    // 创建
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    // 提示
    [app registerUserNotificationSettings:setting];
    
    // App设置Badge
    app.applicationIconBadgeNumber += 1;
    
    // 联网指示
    app.networkActivityIndicatorVisible = YES;
    
    // 跳转URL
    //!!!: 不要缺少"http://"
    // NSURL *url = [NSURL URLWithString:@"http://g.cn"];
    // [app openURL:url];
}

// Reset按钮
- (IBAction)reset:(UIButton *)sender {
    
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 0;
   
    // UIApplication统一修改状态栏
    //!!!: info.plist: 添加最后一项参数:View controller-based status bar appearance: NO;
    // app.statusBarStyle = UIStatusBarStyleLightContent;
    [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

// 控制器的状态栏, 默认控制器管理
// 也可UIApplication管理
/*
 - (UIStatusBarStyle)preferredStatusBarStyle
 {
     return UIStatusBarStyleLightContent;
 }
 - (BOOL)prefersStatusBarHidden
 {
     return YES;
 }
*/


@end
