//
//  AppViewController.m
//  24-AppListOL
//
//  Created by Aixtuz Kang on 15/7/19.
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
// 定义字典做操作缓存
@property (nonatomic, strong) NSMutableDictionary *operations;

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

// 懒加载操作缓存
- (NSMutableDictionary *)operations {
    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
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
    
    //FIXME: 以下, 改用图片和操作缓存,解决图片不显示和错位问题
    
    // 已设置name和download,若图片为空,直接返回
    if (app.icon == nil) {
        return cell;
    }
    
    // 根据URL从缓存中取图片
    UIImage *image0 = self.images[app.icon];
    if (image0) {
        
        // 缓存中有图片则直接赋值
        cell.imageView.image = image0;
        
    } else {
        
        // 缓存无图片则设置占位图
        cell.imageView.image = [UIImage imageNamed:@"placeholder"];
        
        // 根据URL从缓存中取操作
        DLImageOperation *op = self.operations[app.icon];
        
        // 缓存无操作, 才创建操作
        if (op == nil) {
            
            // 实例化操作对象
            DLImageOperation *op =[[DLImageOperation alloc] init];
            
            // 有操作(操作有图片),则存入缓存
            if (app.icon && op) {
                [self.operations setObject:op forKey:app.icon];
            }
            
            // 解析模型的url, 指定下载图片
            op.urlStr = app.icon;
            
            //!!!: self与block循环引用问题
            // __weak typeof(self)weakSelf = self;
            
            // 为设置图片方法传入block内容
            [op setImageWithBlock:^(DLImageOperation *op) {
                
                if (op.img) {
                    // 图片存在则存入缓存:images
                    [self.images setObject:op.img forKey:app.icon];
                    
                    // 刷新数据,相当于调用cellForRowAtIndexPaths
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    
                    // cellForRowAtIndexPaths图片刷新完毕,则清除对应缓存
                    [self.operations removeObjectForKey:app.icon];
                }
            }];
            // 操作加入队列, 则执行op的main方法
            [self.queue addOperation:op];
        }
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
    
    // 清空缓存
    [self.images removeAllObjects];
    [self.operations removeAllObjects];

}

@end

