//
//  ViewController.m
//  24-TableViewEdit
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "HeroModel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

// 字典数组存储数据(为实现插入数据,故用Mutable)
@property (strong, nonatomic) NSMutableArray *heros;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置tableView代理为VC;
    self.tableView.delegate = self;
    
}

// 延迟加载数据
- (NSMutableArray *)heros {
    
    if (_heros == nil) {
        // 获取plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Heros" ofType:@"plist"];
        
        // 字典数组
        NSArray *dictArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        // 可变数组存储转换后模型
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            
            // 字典转模型
            HeroModel *heroModel = [[HeroModel alloc] initWithDict:dict];
            
            // 可变数组存储模型
            [tempArray addObject:heroModel];
        }
        _heros = tempArray;
    }
    return _heros;
}


#pragma mark - tableView 三加三

// 1. 返回组数，默认1，不必重写

// 2. 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.heros.count;
}

// 3. 填充行数据，行数决定此方法调用次数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 定义标识符，查找缓冲池
    NSString *ID = @"hero";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 缓冲池没有则创建
    if (cell == nil) {
        // 创建的时subtitle系统类型的cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 缓冲池找到cell，或者创建完cell，则从self.heros里取出对应row的模型用于赋值
    HeroModel *heroModel = self.heros[indexPath.row];
    
    // 赋值cell的数据
    cell.imageView.image = [UIImage imageNamed:heroModel.icon];
    cell.textLabel.text = heroModel.name;
    cell.detailTextLabel.text = heroModel.intro;
    
    // 枚举设置Cell右侧标识类型
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 返回cell填充行
    return cell;
}


#pragma mark - 点击弹框 + 名称修改

// VC做代理(遵守协议)，监听cell点击，弹框显示名称
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取模型
    HeroModel *heroModel = self.heros[indexPath.row];
    
    // 创建弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改名称" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"布局", @"确定", nil];
    
    // 弹框类型
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    // 获取文本
    UITextField *textField = [alert textFieldAtIndex:0];
    
    // 记录点击行
    alert.tag = indexPath.row;
    
    // 获取名称
    textField.text = heroModel.name;
    
    // 点击的标题
    // NSLog(@"%@",textField.text);
    
    // 设置VC为alert代理，监听确定按钮；
    alert.delegate = self;
    
    [alert show];
}

// VC做Alert代理, 遵守代理协议,
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        self.tableView.editing = !self.tableView.editing;
    }
    
    // 点击确定按钮;
    if (buttonIndex == 2) {
        
        // 取出指定row模型
        HeroModel *model = self.heros[alertView.tag];
        
        // 刷新模型数据
        model.name = [alertView textFieldAtIndex:0].text;
        
        // 指定行
        NSIndexPath *index = [NSIndexPath indexPathForRow:alertView.tag inSection:0];
        
        // 刷新指定行
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationLeft];
    }
}


#pragma mark - 增删行

// 设置每行可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 设置Cell编辑模式

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 插入模式
    return UITableViewCellEditingStyleInsert;
    
    // 删除模式
    // return UITableViewCellEditingStyleDelete
}

// 实现编辑模式
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        // 创建模型
        HeroModel *heroModel = [[HeroModel alloc] init];
        
        // 设置参数
        heroModel.name = @"插入一条数据";
        
        // 插入模型
        [self.heros insertObject:heroModel atIndex:indexPath.row];
        
        // 插入数据
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}

#pragma mark - 移动行

// 设置Cell可移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 实现移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.heros exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}


#pragma mark - 粘贴赋值

// 设置可粘贴赋值
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return YES;
}

// 允许弹出复制菜单
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 实现粘贴赋值
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    // 获取当前行的数据模型(提出if外,二者均可用)
    //!!!: 注意indexPath是包含section&row的参数,要用row需要取出:indexPath.row;
    HeroModel *heroModel = self.heros[indexPath.row];
    
    if (action == @selector(copy:)) {
        
        // 复制行数据
        [UIPasteboard generalPasteboard].string = heroModel.name;
    }
    
    if (action == @selector(paste:)) {
        // 取出剪切版
        NSString *str = [UIPasteboard generalPasteboard].string;
        
        // 赋予模型属性
        heroModel.name = str;
        
        // 刷新数据
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

//!!!: 刷新rowsAtIndexPath是数组,需要根据indexPath取出数组元素;


@end


