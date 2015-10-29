//
//  ViewController.m
//  16-AppMgrXib
//
//  Created by Aixtuz Kang on 15/5/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *apps;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 获取界面宽度
    CGFloat viewW = self.view.frame.size.width;
    
    // 设定总列数
    int totleCol = 3;
    
    // 设置appView尺寸
    CGFloat appViewW = 100;
    CGFloat appViewH = 120;
    
    // 设置边距和间距
    CGFloat marginX = 20;
    CGFloat marginY = 20;
    CGFloat marginTop = 50;
    CGFloat marginLeft = (viewW - appViewW * totleCol - (totleCol - 1) * marginX) * 0.5;
    
    // 布局appView
    for (int i = 0; i < self.apps.count; i++) {
        
        // 计算行列
        int row = i / totleCol;
        int col = i % totleCol;
        
        // 创建appView
        //!!!: loadNibNamed:方法返回数组，按照Xib中的顺序加载
        UIView *appView = [[[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
        
        // 设置归属
        [self.view addSubview:appView];
        
        // 设置appView的frame
        appView.frame = CGRectMake(marginLeft + (appViewW + marginX) * col, marginTop + (appViewH + marginY) * row, appViewW, appViewH);
        
        // 取出模型
        AppModel *appModel = self.apps[i];
        
        // 获取图标并赋值
        UIImageView *icon = appView.subviews[0];
        icon.image = [UIImage imageNamed:appModel.icon];
        
        // 获取名称并赋值
        UILabel *name = appView.subviews[1];
        name.text = appModel.name;
        //!!!: loadNibNamed:加载Xib时,提示Error"方法不存在",尝试Xib中交换几次控件顺序编译;
    }
}

// 延迟加载
- (NSArray *)apps {
    
    if (_apps == nil) {
        
        // 获取plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"];
        
        // 加载plist
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 创建模型数组
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        
        // 遍历字典数组，字典转模型
        for (NSDictionary *dict in dictArray) {
            
            // 初始化模型，利用重写的init直接实现字典转模型
            AppModel *appModel = [[AppModel alloc] initWithDict:dict];
            
            // 存入模型数组
            [modelArray addObject:appModel];
            
        }
        _apps = modelArray;
    }
    return _apps;
}

@end
    
