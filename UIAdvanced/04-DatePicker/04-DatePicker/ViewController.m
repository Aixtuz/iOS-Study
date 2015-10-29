//
//  ViewController.m
//  04-DatePicker
//
//  Created by Aixtuz Kang on 15/6/17.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 日期输入框
@property (weak, nonatomic) IBOutlet UITextField *dateText;
// DatePicker
@property (weak, nonatomic) UIDatePicker *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建DataPicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    // 设置语言
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    // 设置日期模式
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    // 监听DatePicker值改变
    [datePicker addTarget:self action:@selector(dateChange) forControlEvents:UIControlEventValueChanged];
    
    
    // TextField弹出DatePicker
    self.dateText.inputView = datePicker;
    // 属性引用
    self.datePicker = datePicker;
    
    // 创建工具条
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    // 设置frame(宽度无效,等于datepicker)
    toolBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    // 设置背景色
    toolBar.barTintColor = [UIColor whiteColor];
    // 设置前景色
    toolBar.tintColor = [UIColor purpleColor];
    
    // 向工具栏添加 BarButtonItem
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"点我没用" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // 弹簧控件
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    toolBar.items = @[item1, item2, item3];
    
    // 工具条加到键盘上
    self.dateText.inputAccessoryView = toolBar;
}

- (void)dateChange {
    // 日期格式化
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    
    // 将用户选择的日期设置给文本框
    self.dateText.text = [formatter stringFromDate:self.datePicker.date];
}

- (void)done {
    [self.view endEditing:YES];
}

@end
