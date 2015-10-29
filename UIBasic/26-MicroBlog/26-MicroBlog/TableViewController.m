//
//  ViewController.m
//  26-MicroBlog
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "TableViewController.h"
#import "MicroBlog.h"
#import "MicroBlogViewCell.h"
#import "MicroBlogFrame.h"

@interface TableViewController ()

// 私有属性，用于加载字典转模型后的数组
// @property (strong, nonatomic) NSMutableArray *microBlogs;
//!!!: 封装frame模型后，数据模型通过解析frame模型，类之间只传递frame模型,所有和数据模型有关的方法，全不改写成通过frame模型取数据
@property (nonatomic, strong) NSMutableArray *microBlogFrames;

@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 搭建好界面和模型,字典转转模型写完，先设定高度查看是否有，以后算出高度替换掉;
    // self.tableView.rowHeight = 200;
    
    //!!!: microBlogs：拿到字典转模型后的模型数组，先验证是否有数据
    // NSLog(@"%@", self.microBlogs);
    
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

//!!!: 重写数据源方法之前，可先设定行高查看效果；
// 数据源方法
// 返回section默认1，可不重写
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 返回cell数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 模型数组元素个数，就是cell数
    return self.microBlogFrames.count;
}

// 返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 先调用Cell初始化方法，创建一个Cell
    //!!!: 调用cell类创建cell对象时，注意是自定义的cell类名；
    MicroBlogViewCell *cell = [MicroBlogViewCell microBlogWithTableView:tableView];
    
    // cell中的microBlog模型 接收 控制器属性microBlogs模型数组中的第几个row的数据
    cell.microBlogFrame = self.microBlogFrames[indexPath.row];
    
    // 返回cell给tableView显示
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 取出指定row的frame
    MicroBlogFrame *frame = self.microBlogFrames[indexPath.row];
    // 返回其中计算的行高
    //!!!: 用于检查接收的行高是否正常：NSLog(@"行高%f", frame.rowHeight);
    return frame.rowHeight;
    
}

// 重写microBlogs的getter方法，实现数据懒加载
// 封装frame后，改写frame的getter方法,实现懒加载
- (NSMutableArray *)microBlogFrames {
    
    // 判断：为空才加载
    if (_microBlogFrames == nil) {
        
        // 取出加载plist后返回的模型数组
        NSArray *microBlogs = [MicroBlog microBlogs];
        
        // 可变数组 存储 加载plist的数据模型数据 赋予 frame后的frame数组
        NSMutableArray * arrayM = [NSMutableArray array];
        
        for (MicroBlog *microBlog in microBlogs) {
            MicroBlogFrame *frame = [[MicroBlogFrame alloc] init];
            frame.microBlog = microBlog;
            // 汇总数据模型刷新后的frame数组
            [arrayM addObject:frame];
        }
        _microBlogFrames = arrayM;
    }
    return _microBlogFrames;
}


@end
