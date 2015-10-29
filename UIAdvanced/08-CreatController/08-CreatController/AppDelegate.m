//
//  AppDelegate.m
//  08-CreatController
//
//  Created by Aixtuz Kang on 15/6/21.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AppDelegate.h"
#import "KCLViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建UIWindow
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    /*
     //!!!: 创建控制器的第一种方式 : alloc + init;
     // 创建控制器
     KCLViewController *vc = [[KCLViewController alloc] init];
     vc.view.backgroundColor = [UIColor blueColor];
     */

    /*
    //!!!: 创建控制器的第二种方式 : 通过加载storyboard创建;
    // 加载storyboard文件
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KCL" bundle:[NSBundle mainBundle]];
    
    // 通过StoryBoard加载初始化控制器
    //UIViewController *vc = [storyboard instantiateInitialViewController];
    
    // 通过storyboard ID加载指定控制器
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"green"];
    */
   
    //!!!: 创建控制器的第三种方式 : 通过xib来创建控制器;
    KCLViewController *vc = [[KCLViewController alloc] initWithNibName:@"KCLView" bundle:nil];
    // 设置根控制器
    self.window.rootViewController = vc;
    
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
