//
//  ViewController.m
//  03-NationalFlag
//
//  Created by Aixtuz Kang on 15/6/16.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "Flag.h"
#import "FlagView.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

// PickView
@property (weak, nonatomic) IBOutlet UIPickerView *pickViewFlag;


// 懒加载
@property (strong, nonatomic) NSArray *flags;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 数据源方法

// 返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// 返回行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.flags.count;
}

// 测试行数据显示
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    Flag *flag = self.flags[row];
//    return flag.name;
//}

#pragma mark - 代理方法
// 自定义view方法
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    // 取出对应模型
    Flag *flag = self.flags[row];
    FlagView *flagView = [FlagView flagViewWithView:view];
    flagView.frame = CGRectMake(0, 0, pickerView.frame.size.width, [FlagView rowHeight]);
    // 把模型数据设置给自定义View
    flagView.flag = flag;
    return flagView;
}

// 返回行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return [FlagView rowHeight];
}

#pragma mark - 懒加载
- (NSArray *)flags {
    if (_flags == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            Flag *flag = [Flag flagWithDict:dict];
            [tempArray addObject:flag];
        }
        _flags = tempArray;
    }
    return _flags;
}


@end
