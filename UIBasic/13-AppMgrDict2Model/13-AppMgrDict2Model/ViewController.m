//
//  ViewController.m
//  13-AppMgrDict2Model
//
//  Created by Aixtuz Kang on 15/5/26.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"

@interface ViewController ()

@property(strong, nonatomic) NSArray *apps;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //!!!: frame计算
    // 获取界面宽度
    CGFloat viewW = self.view.frame.size.width;

    // 设定总列数
    int totalCols = 3;

    // 设置appView尺寸
    CGFloat appViewW = 100;
    CGFloat appViewH = 120;

    // 设置边距和间距
    CGFloat marginX = 20;
    CGFloat marginY = 20;
    CGFloat marginTop = 50;
    CGFloat marginLeft = (viewW - totalCols * appViewW - (totalCols - 1) * marginX) * 0.5;

    // 布局appView
    for (int i = 0; i < self.apps.count; i++) {

        // 计算行列
        int row = i / totalCols;
        int col = i % totalCols;

        // 创建appView
        UIView *appView = [[UIView alloc] init];

        // 设置归属
        [self.view addSubview:appView];

        // 设置appView的frame
        appView.frame = CGRectMake(marginLeft + (appViewW + marginX) * col, marginTop + (appViewH + marginY) * row, appViewW, appViewH);

        // 设置背景
        appView.backgroundColor = [UIColor greenColor];
    }
}

// 延迟加载
//!!!: 字典转模型
- (NSArray *)apps {

    if (_apps == nil) {

        // 获取路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"];

        // 加载plist文件
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];

        // 存储模型的数组
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];

        // 遍历字典数组,字典转模型
        for (NSDictionary *dict in dictArray) {

            // 创建模型对象
            AppModel *appModel = [[AppModel alloc] init];

            // 字典键值赋予模型属性
            appModel.icon = dict[@"icon"];
            appModel.name = dict[@"name"];

            // 数组存储模型
            [modelArray addObject:appModel];
            
        }
        _apps = modelArray;
    }
    return _apps;
}

@end

