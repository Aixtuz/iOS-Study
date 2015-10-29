//
//  EditController.m
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/23.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "EditController.h"
#import "Contact.h"

@interface EditController ()

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *save;



@end

@implementation EditController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 接收传入的模型数据
    self.name.text = self.contact.name;
    self.phone.text = self.contact.phone;
    
    // 初始保存按钮隐藏
    self.save.hidden = YES;
    // 文本框不可编辑
    self.name.enabled = NO;
    self.phone.enabled = NO;
    
    // 登录按钮初始不可用,监听文本框change通知,二者不空才能登录
    // self.btnLogin.enabled = NO;
    [self textChange];
    
    // 获取通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //!!!: 注册监听: self监听object的name通知,则调用selector方法;
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.name];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phone];
}

// textField变化后调用的方法
- (void)textChange {
    // 帐号密码不为空,才能登录
    self.save.enabled = (self.name.text.length > 0 && self.phone.text.length > 0);
}

// 监听编辑按钮
- (IBAction)editBtn:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        
        // 编辑点击变取消
        sender.title = @"取消";
        
        // 文本框可编辑
        self.name.enabled = YES;
        self.phone.enabled = YES;
        
        // 保存按钮显示
        self.save.hidden = NO;
        
        // 设置电话号码文本框为第一响应者
        [self.phone becomeFirstResponder];
        
    } else {
        
        // 取消点击变编辑
        sender.title = @"编辑";
        
        // 文本框不可编辑
        self.name.enabled = NO;
        self.phone.enabled = NO;
        
        // 保存按钮隐藏
        self.save.hidden = YES;
        
        // 文本内容恢复
        self.name.text = self.contact.name;
        self.phone.text = self.contact.phone;
    }
}

// 监听保存按钮
- (IBAction)saveBtn:(UIButton *)sender {
    
    // 数据存入模型
    self.contact.name = self.name.text;
    self.contact.phone = self.phone.text;
    
    // 如果代理实现了代理方法,则调用
    if ([self.delegate respondsToSelector:@selector(editController:)]) {
        [self.delegate editController:self];
    }
    // 返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

// 移除通知监听
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
