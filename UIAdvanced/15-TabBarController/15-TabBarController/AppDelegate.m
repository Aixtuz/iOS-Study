//
//  AppDelegate.m
//  15-TabBarController
//
//  Created by Aixtuz Kang on 15/6/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// 通过设置默认启动storyboard: main, 来切换不同的使用方式〕;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 获取UIWindow
    //!!!: self.window已存在,不要 UIWindow *window 去创建;
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 创建UITabBarVontroller
    UITabBarController *tbc = [[UITabBarController alloc] init];
    
    // 创建被管理的控制器
    OneViewController *vc1 = [[OneViewController alloc] init];
    TwoViewController *vc2 = [[TwoViewController alloc] init];
    ThreeViewController *vc3 = [[ThreeViewController alloc] init];
    
    // 设置显示内容
    
    // 可以在viewDidLoad中设置当前Controller内容，也可在代理中监听didFinishLaunching中设置;
    // 按钮的标题,图片,和通知数
    vc1.tabBarItem.title = @"联系人";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tab_buddy_nor"];
    vc1.tabBarItem.badgeValue = @"10";
    
    vc2.tabBarItem.title = @"发现";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    UIImage *img = [UIImage imageNamed:@"tabbar_discoverHL"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.selectedImage = img;
    
    vc3.tabBarItem.title = @"动态";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tab_qworld_nor"]; 
    
    // 添加到创建的TabBar控制器中
    tbc.viewControllers = @[vc1, vc2, vc3];
    
    // 设置窗口的根控制器
    self.window.rootViewController = tbc;
    
    // 设置主窗口并显示
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
