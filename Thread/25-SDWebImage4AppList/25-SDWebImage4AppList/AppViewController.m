//
//  AppViewController.m
//  25-SDWebImage4AppList
//
//  Created by Aixtuz Kang on 15/7/20.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AppViewController.h"
#import "App.h"
#import "UIImageView+WebCache.h"

@interface AppViewController ()

// 全局数据源
@property (nonatomic, strong) NSMutableArray *apps;

@end

//!!!: 问题: 1.图片点击才显示 2.图片错位
/*
 * 方案:
 * 1. 下载图片,内存缓存,cell从内存读取图片,避免滚动快,下载慢,而重复赋值;
 * 2. 创建操作,内存缓存,每次下载图片都判断操作存在否,不存在才创建;
 */

@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 异步下载图片: 返回的是数组,注意取元素
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"%@",path);
}

// 字典转模型方法, 返回模型数组
- (NSMutableArray *)dict2Model {
    
    // 获取plist文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
    
    // 获取字典数组
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    
    // 可变数组存储转换后的模型
    NSMutableArray *arrayM = [NSMutableArray array];
    
    // Block遍历转模型
    [dictArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSDictionary *dict = obj;
        
        // 字典转模型的初始化方法
        App *app = [App appWithDict:dict];
        
        // 汇总存储
        [arrayM addObject:app];
    }];
    return arrayM;
}

// 懒加载apps
- (NSMutableArray *)apps {
    if (_apps == nil) {
        
        // 调用字典转模型方法,返回模型数组;
        _apps = [self dict2Model];
    }
    return _apps;
}

#pragma mark - 数据源方法

// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //???: 为什么要加static
    static NSString *reuseId = @"App";
    
    // 有则缓冲池出列, 无则创建
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    // 获取模型,解析数据
    App *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    
    // 占位图image,下载图url
    NSURL *url = [NSURL URLWithString:app.icon];
    UIImage *image = [UIImage imageNamed:@"placeholder"];
    
    // Failed: 失败重来; priority: UI优先;
    [cell.imageView sd_setImageWithURL:url placeholderImage:image options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    // 下载进度
    [cell.imageView sd_setImageWithURL:url placeholderImage:image options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //!!!: 进度条: 1.receivedSize,当前下载量; 2.expectedSize,总大小;
        NSLog(@"%f", (double)receivedSize / expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // NSLog(@"下载完成");
    }];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"取消所有操作");
}

@end

