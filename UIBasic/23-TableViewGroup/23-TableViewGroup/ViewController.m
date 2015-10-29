//
//  ViewController.m
//  23-TableViewGroup
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "CarGroup.h"
#import "CarModel.h"

@interface ViewController () <UITableViewDataSource>

// 用于加载初始字典数组的数据
@property (strong, nonatomic) NSArray *carGroups;
// 表格控件
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

// 延迟加载数据
- (NSArray *)carGroups {
    
    //!!!: 延迟加载:取数据为空才加载,注意:不要再set方法中调用set方法(self.carGroups)
    if (_carGroups == nil) {
        // 获取plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Cars" ofType:@"plist"];
        
        // 加载plist
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 可变数组存模型
        //???: alloc+init && new VS array 的区别？
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            
            // 字典转模型
            CarGroup *carGroup = [CarGroup carGroupWithDict:dict];
            // 添加到数组
            [tempArray addObject:carGroup];
        }
        _carGroups = tempArray;
    }
    return _carGroups;
}

#pragma mark - 设置tableView 三+三

//!!!: tableView 使用注意：dataSource，1.数据源连线,2.遵守协议
// 第一步：返回组数,整型
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.carGroups.count;
}

// 第二步：返回行数，整型
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //!!!: 字典中的数据取出后才会提示
    CarGroup *carGroup = self.carGroups[section];
    return carGroup.cars.count;
}

// 第三部：设置 设置行内容，UITableViewCell，行数决定此方法调用次数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 每次调用此方法，先缓存查找复用，没有才创建
    // 定义标识符
    static NSString *ID = @"car";
    // 缓冲池查找相同标识符的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 创建并初始化cell
    
    // 取出模型用于赋值
    //!!!: 若写if里,则仅复用缓冲池cell才赋值数据,写在此处无论复用or新建,均能设置数据
    CarGroup *carGoup = self.carGroups[indexPath.section];
    CarModel *carModel = carGoup.cars[indexPath.row];
    // cell中显示 icon 和 name
    cell.imageView.image = [UIImage imageNamed:carModel.icon];
    cell.textLabel.text = carModel.name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 返回cell用于填充数据
    return cell;
}

// 可选一：设置组头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // 取出当前组的数据模型
    CarGroup *carGroup = self.carGroups[section];
    // 取出carGroup对象的title属性，返回给组头
    return carGroup.title;
}

// 可选二：设置组尾
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    // 取出当前组的数据模型
    CarGroup *carGroup = self.carGroups[section];
    // 取出carGroup对象的title属性，返回给组头
    return carGroup.end;
}


// 可选三：设置索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // 返回 self的carGroups属性中的字典key:@"title"对应的value 为 索引值
    return [self.carGroups valueForKeyPath:@"title"];
}

@end
