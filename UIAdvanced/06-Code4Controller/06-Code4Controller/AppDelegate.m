//
//  AppDelegate.m
//  06-Code4Controller
//
//  Created by Aixtuz Kang on 15/6/21.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AppDelegate.h"
#import "KCLViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//!!!: 启动过程: Step 01 - Launching完毕;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建window对象
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // NSLog(@"%@", self.window);
    
    // 创建控制器
    KCLViewController *vc = [[KCLViewController alloc] init];
    
    // 设置根控制器
    self.window.rootViewController = vc;
    
    // 设置显示
    //!!!: 不要错用方法: makeKeyWindow;
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
