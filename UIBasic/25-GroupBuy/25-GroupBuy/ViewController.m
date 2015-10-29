//
//  ViewController.m
//  25-GroupBuy
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

//!!!: 引用头文件注意不要用中文#号
#import "ViewController.h"
#import "GroupBuy.h"
#import "GroupBuyCell.h"
#import "GroupBuyHeaderView.h"
#import "GroupBuyFooterView.h"

@interface ViewController () <UITableViewDataSource, GroupBuyFooterViewDelegate>

// VC 拥有 TableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// groupBuys 模型数组存储数据
@property (strong, nonatomic) NSMutableArray *groupBuys;

@end

@implementation ViewController

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建并加载HeaderView
    self.tableView.tableHeaderView = [GroupBuyHeaderView groupBuyHeaderView];
    
    // 设置Cell行高
    self.tableView.rowHeight = 100;
    
    // 创建并加载FooterView
    GroupBuyFooterView *footView = [GroupBuyFooterView GroupBuyFooterView];
    self.tableView.tableFooterView = footView;
    
    // 设置VC为footView代理
    //!!!: 有对象，才有代理属性，因此，上文创建的FooterView不要和加载HeadView一样直接加载，应先定义指针指向，然后用指针名加载，则指针名可用于此处设定代理；
    footView.delegate = self;
}

// 实现协议声明的代理方法
- (void)loadWithFooterView:(GroupBuyFooterView *)footerView {
    
    //???:  模拟延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 创建模型
        GroupBuy *groupBuy = [[GroupBuy alloc] init];
        
        // 设置数据
        groupBuy.title = @"苍老师按摩";
        groupBuy.price = @"100";
        groupBuy.buyCount = @"0";
        groupBuy.icon = @"70e4761e6ecf56a2d78685df7157f010";
        
        // 添加模型
        [self.groupBuys addObject:groupBuy];
        
        // 刷新数据
        //!!!: 全体刷新：[self.tableView reloadData];
        // 定义插入位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.groupBuys.count - 1 inSection:0];
        // 插入新行
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        // 停止加载动画
        [footerView stopLoading];
        
        // 把 IndexPath 对应行,滚到tableView的某个位置(wift 可用)
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    });
}

// 重写getter方法实现模型数组的懒加载
- (NSMutableArray *)groupBuys {
    
    // 为空才加载
    if (_groupBuys == nil) {
        // 调用GroupBuy封装加载plist的方法(其中调用字典转模型)
        // 最终返回模型数组赋予groupBuys属性，需引入头文件
        _groupBuys = [GroupBuy groupBuys];
    }
    return _groupBuys;
}

// 设定VC为TableView数据源，并遵守数据源协议，然后实现数据源三方法
// 1. 返回Section数默认1，不必实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 2. 返回Row数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 行数 = 存储数据的模型数组元素个数
    return self.groupBuys.count;
}
// 3. 返回Cell内容，调用次数取决于2.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //!!!:  (缓冲池出列 + 加载新Cell)封装为GroupBuyCell中的创建cell的方法，调用需要引用头文件；
    GroupBuyCell *cell = (GroupBuyCell *)[GroupBuyCell groupBuyWithTableView:tableView];
    
    // 设置cell的数据，调用cell的setter方法,传入数据模型
    cell.groupBuy = self.groupBuys[indexPath.row];
    
    return cell;
}

@end

