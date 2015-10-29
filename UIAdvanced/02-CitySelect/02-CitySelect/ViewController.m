//
//  ViewController.m
//  02-CitySelect
//
//  Created by Aixtuz Kang on 15/6/15.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "Province.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

// 懒加载数据
@property (strong, nonatomic) NSArray *provinces;

@property (weak, nonatomic) IBOutlet UILabel *province;
@property (weak, nonatomic) IBOutlet UILabel *city;

@property (strong, nonatomic) NSArray *tempCities;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 取出第一个模型
    Province *province = self.provinces[0];
    // 预设省
    self.province.text = province.name;
    // 预设市
    self.city.text = province.cities[0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 数据源方法

// 返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// 返回行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        // 第一列返回省数
        return self.provinces.count;
    } else {
        // 第一列选中的行号
        NSInteger index = [pickerView selectedRowInComponent:0];
        // 取出对应行的模型
        Province *province = self.provinces[index];
        self.tempCities = province.cities;
        // 返回对应模型的城市数
        return self.tempCities.count;
    }
}


#pragma mark - 代理方法

// 返回组内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        // 取出第一列选中行对应的模型
        Province *provance = self.provinces[row];
        // 返回省名
        return provance.name;
    } else {
//        // 第一列选中的行号
//        NSInteger index = [pickerView selectedRowInComponent:0];
//        // 取出对应模型
//        Province *province = self.provinces[index];
//        // 返回第二列所选行号的城市名
//        return province.cities[row];
        return self.tempCities[row];
    }
}

// 选中0列后刷新1列数据
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // 选中第一列
    if (component == 0) {
        // 刷新第二列数据
        [pickerView reloadComponent:1];
        // 复位到选中第一个
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    // 获取每列的选中序号
    NSInteger indexP = [pickerView selectedRowInComponent:0];
    NSInteger indexC = [pickerView selectedRowInComponent:1];
    // 根据序号取出模型
    Province *province = self.provinces[indexP];
    // 显示出对应数据
    self.province.text = province.name;
    self.city.text = self.tempCities[indexC];
}


#pragma mark - 懒加载

- (NSArray *)provinces {
    if (_provinces == nil) {
        // 获取plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
        // 加载字典数组
        NSArray *dictArray = [[NSArray alloc] initWithContentsOfFile:path];
        // 存储模型数组
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        // 字典转模型
        for (NSDictionary *dict in dictArray) {
            Province *province = [Province provinceWithDict:dict];
            [tempArray addObject:province];
        }
        _provinces = tempArray;
    }
    return _provinces;
}

@end
