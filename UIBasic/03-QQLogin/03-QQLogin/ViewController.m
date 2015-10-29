//
//  ViewController.m
//  03-QQLogin
//
//  Created by Aixtuz Kang on 15/5/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// QQ帐号
@property (weak, nonatomic) IBOutlet UITextField *account;

// QQ密码
@property (weak, nonatomic) IBOutlet UITextField *pwd;

// 监听登录按钮
- (IBAction)login;

@end


@implementation ViewController

// 监听登录按钮
- (IBAction)login {
    
    // 1. 获取输入框内容
    NSString *str1 = self.account.text;
    NSString *str2 = self.pwd.text;
    
    // 2. QQ号码&密码长度不符，则中部弹框
    if (str1.length < 5 || str1.length > 10 || str2.length < 6) {
        
        // 2.1. 释放键盘
        [self.view endEditing:YES];
        
        //!!!:  2.2. 创建中部弹框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意！" message:@"帐号密码输入有误！" preferredStyle:UIAlertControllerStyleAlert];
        
        // 2.3. 增加取消登录并重新输入的按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:nil]];
        
        // 2.4. 显示中部弹框
        [self presentViewController:alert animated:NO completion:nil];
        
    } else {
        
        // 3. 校验通过，则底部弹框
        // 3.1. 释放键盘
        [self.view endEditing:YES];
        
        //!!!:  3.2. 创建底部弹框
        UIAlertController *bottomAlert = [UIAlertController alertControllerWithTitle:@"登录中..." message:@"检测网络...\n校验帐号密码...\n" preferredStyle:UIAlertControllerStyleActionSheet];
        
        // 3.3. 增加取消登录并重新输入的按钮
        [bottomAlert addAction:[UIAlertAction actionWithTitle:@"取消登录" style:UIAlertActionStyleCancel handler:nil]];
        
        // 3.4. 显示底部弹框
        [self presentViewController:bottomAlert animated:NO completion:nil];
    }
}

@end

