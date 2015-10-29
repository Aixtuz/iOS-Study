//
//  AppDelegate.h
//  26-NSCache4AppList
//
//  Created by Aixtuz Kang on 15/7/21.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AppViewController.h"
#import "App.h"
#import "DLImageOperation.h"

@interface AppViewController ()

// 全局数据源
@property (nonatomic, strong) NSMutableArray *apps;
// 非主队列
@property (nonatomic, strong) NSOperationQueue *queue;

// 定义字典做图片缓存
@property (nonatomic, strong) NSMutableDictionary *images;

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

// 懒加载queue
- (NSOperationQueue *)queue {
    if (_queue == nil) {
        
        // 初始化并设置最大并发
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:6];
    }
    return _queue;
}

// 懒加载图片缓存
-(NSMutableDictionary *)images {
    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

#pragma mark - 数据源方法

// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 重用ID
    NSString *reuseId = @"App";
    
    // 有则缓冲池出列, 无则创建
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    // 获取模型,解析数据
    App *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    
    // 判断指定图片缓存是否存存在
    UIImage *image0 = self.images[app.icon];
    if (image0) {
        
        // 缓存中有图片则直接赋值
        cell.imageView.image = image0;
        NSLog(@"读取缓存");
        
    } else {
        
        // 缓存无图片则设置占位图
        cell.imageView.image = [UIImage imageNamed:@"placeholder"];
        
        // 根据URL从缓存中取操作
        DLImageOperation *op = [[DLImageOperation alloc] init];
        
        op.urlStr = app.icon;

        // 为设置图片方法传入block内容
        [op setImageWithBlock:^(DLImageOperation *op) {
                
            if (op.img) {
                
                // 图片存在则存入缓存:images
                [self.images setObject:op.img forKey:app.icon];
                    
                // 刷新数据,相当于调用cellForRowAtIndexPaths
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
            }
        }];
        // 操作加入队列, 则执行op的main方法
        [self.queue addOperation:op];
    }
    return cell;
}

#pragma mark - UIScrollView代理方法

// 监听滚动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 暂停操作
    [self.queue setSuspended:YES];
}

// 监听滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 恢复操作
    [self.queue setSuspended:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // 取消所有操作
    [self.queue cancelAllOperations];

}

@end

