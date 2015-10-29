//
//  ViewController.m
//  01-Calculator
//
//  Created by Aixtuz Kang on 15/5/23.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//!!!: IBOutlet, 属性 = 指针, 连线 = 指向, 通过指针操作对象;
// 被减数
@property (weak, nonatomic) IBOutlet UITextField *text1;
// 减数
@property (weak, nonatomic) IBOutlet UITextField *text2;
// 结果
@property (weak, nonatomic) IBOutlet UILabel *result;

//!!!: IBAction, 连线 = 监听 (默认:TouchUpInside);
// 监听计算按钮
- (IBAction)Count;

@end


@implementation ViewController

//!!!: View加载完成 执行viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 监听计算按钮
- (IBAction)Count {
    
    // 1. 获取UITextField
    //!!!: UITextField点语法get到text属性值
    NSString *str1 = self.text1.text;
    NSString *str2 = self.text2.text;
    
    // 2. 字符串转为整型
    int num1 = [str1 intValue];
    int num2 = [str2 intValue];
    
    // 3. 判断输入
    if (num1 < num2) {
     
        //!!!:  4. 弹框两版本
        // 4.1 ios8- 弹框
        /*
        // 4.1.1 创建弹框
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意！" message:@"输入数字不合理。" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil, nil];
         
        // 4.1.2 显示弹框
        [alert show];
         */
        
        // 4.2 ios8+ 弹框
        // 4.2.1 创建弹框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意！" message:@"输入字符不合理。" preferredStyle:UIAlertControllerStyleAlert];
        
        // 4.2.2 添加取消按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        // 4.2.3 显示弹框
        [self presentViewController:alert animated:NO completion:nil];
        
    } else {
        
        // 5. 计算结果
        int result = num1 - num2;
        
        // 6. 显示结果
        //!!!: 字符串转整型计算,计算结果拼接字符串;
        self.result.text = [NSString stringWithFormat:@"%d", result];
        
    }
    
    //!!!:  7. 释放键盘
    
    // 7.1 释放第一级响应者
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    
    // 7.2 终止第一响应者父级的编辑状态
    [self.view endEditing:YES];
    
}

@end

