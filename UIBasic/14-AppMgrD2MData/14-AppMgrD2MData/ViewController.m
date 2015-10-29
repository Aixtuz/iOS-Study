//
//  ViewController.m
//  14-AppMgrD2M&Data
//
//  Created by Aixtuz Kang on 15/5/27.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"

@interface ViewController ()

// 模型数组
@property (strong, nonatomic) NSArray *apps;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 获取界面宽度
    CGFloat viewW = self.view.frame.size.width;
    
    // 设定总列数
    int totalCol = 3;
    
    // 设置appView尺寸
    CGFloat appViewW = 100;
    CGFloat appViewH = 120;
    
    // 设置边距和间距
    CGFloat marginX = 20;
    CGFloat marginY = 20;
    CGFloat marginTop = 50;
    CGFloat marginLeft = (viewW - totalCol * appViewW - (totalCol - 1) * marginX) * 0.5;
    
    // 布局appView
    for (int i = 0; i < self.apps.count; i++) {
        
        // 计算行列
        CGFloat row = i / totalCol;
        CGFloat col = i % totalCol;
        
        // 创建appView
        UIView *appView = [[UIView alloc] init];
        
        // 设置归属
        [self.view addSubview:appView];
        
        // 设置appView的frame
        appView.frame = CGRectMake(marginLeft + (appViewW + marginX) * col, marginTop + (appViewH + marginY) * row, appViewW, appViewH);
        
        // 设置背景色
        // appView.backgroundColor = [UIColor greenColor];
        
        // 取出模型
        AppModel *appModel = self.apps[i];
        
        // 设置图片
        // 创建ImageView
        UIImageView *icon = [[UIImageView alloc] init];
        // 设置归属
        [appView addSubview:icon];
        // 设置frame
        CGFloat iconW = 72;
        CGFloat iconH = 72;
        CGFloat iconY = 0;
        CGFloat iconX = (appView.frame.size.width - iconW ) * 0.5;
        icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        // 设置图片
        icon.image = [UIImage imageNamed:appModel.icon];
        
        // 设置名称
        // 创建Label
        UILabel *name = [[UILabel alloc] init];
        // 设置归属
        [appView addSubview:name];
        // 设置frame
        CGFloat nameW = appViewW;
        CGFloat nameH = 20;
        CGFloat nameX = 0;
        CGFloat nameY = iconY + iconH;
        name.frame = CGRectMake(nameX, nameY, nameW, nameH);
        // 设置文字
        name.text = appModel.name;
        // 设置字体大小
        //???: 此方法修改的字体大小是什么？
        // [name.font fontWithSize:12];
        name.font = [UIFont systemFontOfSize:12];
        //!!!: 设置align
        name.textAlignment = NSTextAlignmentCenter;

        // 设置按钮
        // 创建按钮
        UIButton *download = [[UIButton alloc] init];
        // 设置归属
        [appView addSubview:download];
        // 设置frame
        CGFloat spaceY = 5;
        CGFloat downloadW = 75;
        CGFloat downloadH = 30;
        CGFloat downloadX = (appViewW - downloadW) * 0.5;
        CGFloat downloadY = nameY + nameH + spaceY;
        download.frame = CGRectMake(downloadX, downloadY, downloadW, downloadH);
        // 设置文字
        [download setTitle:@"下载" forState:UIControlStateNormal];
        [download setTitle:@"已下载" forState:UIControlStateDisabled];
        download.titleLabel.font = [UIFont systemFontOfSize:14];
        // 设置背景
        [download setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [download setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        
    }
    
}

//!!!: 延迟加载
- (NSArray *)apps {
    
    if (_apps == nil) {
        
        // 获取plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"];
        
        // 加载plist中的字典数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 创建可变数组存储模型
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        
        // 遍历字典数组,字典转模型
        for (NSDictionary *dict in dictArray) {
            
            // 创建模型对象
            AppModel *appmodel = [[AppModel alloc] init];
            
            // 字典键值赋予模型属性
            appmodel.icon = dict[@"icon"];
            appmodel.name = dict[@"name"];
            
            // 模型存入数组
            [modelArray addObject:appmodel];
            
        }
        _apps = modelArray;
    }
    return _apps;
}

@end
