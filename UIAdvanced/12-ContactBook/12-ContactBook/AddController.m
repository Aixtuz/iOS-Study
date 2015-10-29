//
//  AddController.m
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/22.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AddController.h"
#import "Contact.h"

@interface AddController ()

// 姓名
@property (weak, nonatomic) IBOutlet UITextField *name;
// 电话
@property (weak, nonatomic) IBOutlet UITextField *phone;
// 保存按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation AddController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 保存按钮初始不可用,监听文本框change通知,二者不空才能保存
    // self.saveBtn.enabled = NO;
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
    self.saveBtn.enabled = (self.name.text.length > 0 && self.phone.text.length > 0);
}

// view Appear
- (void)viewDidAppear:(BOOL)animated {
    
    // 父view显示,子view才能显示
    [super viewDidAppear:animated];
    
    // 自动弹出键盘
    [self.name becomeFirstResponder];
}

// 监听保存按钮
- (IBAction)save:(UIButton *)sender {
    
    // 帐号取出两端空格
    NSString *newName = [self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // 创建模型存储数据
    Contact *contact = [[Contact alloc] init];
    contact.name = newName;
    contact.phone = self.phone.text;
    
    //!!!: 去.h文件中 定义代理及代理协议,在ListController中设置LC遵守协议做AC代理;
    // 若代理实现了代理方法
    if ([self.delegate respondsToSelector:@selector(addController:withContact:)]) {
        [self.delegate addController:self withContact:contact];
    }
    // 返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

// 移除通知监听
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

