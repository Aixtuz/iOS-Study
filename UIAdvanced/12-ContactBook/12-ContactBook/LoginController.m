//
//  LoginController.m
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/22.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "LoginController.h"
#import "MBProgressHUD.h"

@interface LoginController ()

// 帐号
@property (weak, nonatomic) IBOutlet UITextField *loginID;
// 密码
@property (weak, nonatomic) IBOutlet UITextField *loginPwd;
// 记住密码
@property (weak, nonatomic) IBOutlet UISwitch *switchRemember;
// 自动登录
@property (weak, nonatomic) IBOutlet UISwitch *switchAuto;
// 登录按钮
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;


@end

@implementation LoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //!!!: 注册监听: self监听object的name通知,则调用selector方法;
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.loginID];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.loginPwd];
    
    //!!!: 读取用户状态
    // 获取读写偏好设置的对象
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    // 读取数据
    self.loginID.text = [ud objectForKey:@"login_id"];
    self.switchRemember.on = [ud boolForKey:@"switch_rmb"];
    //!!!: 注意BOOL的setter方法用on, getter方法采用isOn;
    self.switchAuto.on = [ud boolForKey:@"switch_auto"];
    
    // 开启记住密码,则读取密码
    if (self.switchRemember.isOn) {
        self.loginPwd.text = [ud objectForKey:@"login_pwd"];
    }
    
    // 开启自动登录,则自动点击login
    if (self.switchAuto.on) {
        [self login:self.btnLogin];
    }
    
    // 登录按钮初始不可用,监听文本框change通知,二者不空才能登录
    // 读取用户状态后,再判断是否为空;
    // self.btnLogin.enabled = NO;
    [self textChange];
}

// textField变化后调用的方法
- (void)textChange {
    // 帐号密码不为空,才能登录
    self.btnLogin.enabled = (self.loginID.text.length > 0 && self.loginPwd.text.length > 0);
}

// 监听记住密码
- (IBAction)switchRememberChange:(UISwitch *)sender {
    
    // 关闭记住密码,则自动登录失效
    if (!sender.isOn) {
        [self.switchAuto setOn:NO animated:YES];
    }
}

// 监听自动登录
- (IBAction)switchAutpChange:(UISwitch *)sender {
    
    // 打开自动登录,则开启记住密码
    if (sender.isOn) {
        [self.switchRemember setOn:YES animated:YES];
    }
}

// 拦截Segue的跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 取得segue指向的控制器
    UIViewController *vc = segue.destinationViewController;
    
    // 将当前文本框ID赋予指向控制器的title
    vc.navigationItem.title = [NSString stringWithFormat:@"%@通讯录", self.loginID.text];
}

// 监听登录按钮
- (IBAction)login:(UIButton *)sender {
    
    // 点击后,禁止再编辑
    [self.view endEditing:YES];
    
    // 获取文本框
    NSString *loginID = self.loginID.text;
    NSString *loginPwd = self.loginPwd.text;
    
    // 校验
    if ( [loginID isEqualToString:@"123"] && [loginPwd isEqualToString:@"123"]) {
        
        // 校验通过,记录用户状态
        [self saveUserState];
        
        //!!!: 第三方框架,创建hud,添加到view并显示
        // 创建hud
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        // 显示模式
        hud.mode = MBProgressHUDModeCustomView;
        // 显示内容;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/success"]];
        // 通知内容
        hud.labelText = @"正在登录...";
        // 遮罩背景
        hud.dimBackground = YES;
        // 设置显示
        [hud show:YES];
        
        // 模拟延迟0.5秒
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 延迟0.5秒后,隐藏hud
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            // 手动segue跳转
            [self performSegueWithIdentifier:@"login2List" sender:@"hello"];
        });
        
    } else {
        
        // 创建hud
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // 设置模式
        hud.mode = MBProgressHUDModeCustomView;
        // 显示内容
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/error"]];
        // 通知内容
        hud.labelText = @"用户名和密码错误!";
        // 背景遮罩
        hud.dimBackground = YES;
        // 设置显示
        [hud show:YES];
        // 延迟隐藏
        [hud hide:YES afterDelay:0.5];
    }
}

// 记录用户信息
- (void)saveUserState {
    
    // 获取读写偏好设置的对象
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    // 写入数据
    [ud setObject:self.loginID.text forKey:@"login_id"];
    [ud setObject:self.loginPwd.text forKey:@"login_pwd"];
    [ud setBool:self.switchRemember.isOn forKey:@"switch_rmb"];
    [ud setBool:self.switchAuto.isOn forKey:@"switch_auto"];
    
    // 立刻同步
    [ud synchronize];
}

// 移除通知监听
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
