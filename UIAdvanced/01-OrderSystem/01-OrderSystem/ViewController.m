//
//  ViewController.m
//  01-OrderSystem
//
//  Created by Aixtuz Kang on 15/6/15.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

// 加载数据
@property (strong, nonatomic) NSArray *foods;

// 显示所选
@property (weak, nonatomic) IBOutlet UILabel *fruit;
@property (weak, nonatomic) IBOutlet UILabel *mainCourse;
@property (weak, nonatomic) IBOutlet UILabel *drink;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

// 监听按钮
- (IBAction)btnClick:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 预设值
    self.fruit.text = self.foods[0][0];
    self.mainCourse.text = self.foods[1][0];
    self.drink.text = self.foods[2][0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClick:(UIButton *)sender {
    for (int i = 0; i < self.foods.count; i++) {
        // 获取随机数范围
        //!!!: id不能用点语法
        NSInteger count = [self.foods[i] count];
        //!!!: 生成0--count-1的数
        u_int32_t num = arc4random_uniform((int)count);
        // 获取当前行号,需要属性对其控制
        NSInteger curNum = [self.pickView selectedRowInComponent:i];
        // 随机相同重随机
        if (num == curNum) {
            num = arc4random_uniform((int)count);
        }
        // 设置选中
        [self.pickView selectRow:num inComponent:i animated:YES];
        // 显示所选
        [self pickerView:self.pickView didSelectRow:num inComponent:i];
    }
}


#pragma mark - 数据源方法

// 返回组数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.foods.count;
}

// 返回行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.foods[component] count];
}


#pragma mark - 代理方法

//!!!: UIPickView 返回行内容,居然时代理方法!
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.foods[component][row];
}

// 监听选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.fruit.text = self.foods[0][row];
    } else if (component == 1) {
        self.mainCourse.text = self.foods[1][row];
    } else {
        self.drink.text = self.foods[2][row];
    }
}


#pragma mark - 懒加载

- (NSArray *)foods {
    if (_foods == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foods" ofType:@"plist"];
        _foods = [NSArray arrayWithContentsOfFile:path];
    }
    return _foods;
}

@end

