//
//  ListController.m
//  12-ContactBook
//
//  Created by Aixtuz Kang on 15/6/22.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ListController.h"
#import "Contact.h"
#import "ContactCell.h"
#import "AddController.h"
#import "EditController.h"

@interface ListController () <addControllerDelegate, EditControllerDelegate>

@property (strong, nonatomic) NSMutableArray *contacts;

@end

@implementation ListController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 监听注销按钮
- (IBAction)logout:(UIBarButtonItem *)sender {
    
    // 创建弹框
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"注意!" message:@"确认注销登录?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 点击确认后执行
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    // 显示弹框
    [self presentViewController:alert animated:YES completion:nil];
}


/*
 // 旧版弹框
 - (IBAction)btn:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"操作提示" delegate:self cancelButtonTitle:@"留在本页" destructiveButtonTitle:@"注销" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
 }
 
 // 监听弹框点击
 - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
 {
    //NSLog(@"%@", @(buttonIndex));
    if (buttonIndex == 0) {
    // 点击index=0的弹框按钮
    }
 }
 */


#pragma mark - 懒加载

- (NSMutableArray *)contacts {
    if  (_contacts == nil) {
        
        /*
         // 初始化数组
         _contacts = [NSMutableArray array];
         
         // 测试模型
         Contact *contact = [[Contact alloc] init];
         // 赋值模型
         contact.name = @"KKK";
         contact.phone = @"1234567890";
         // 存入数组
         [_contacts addObject:contact];
        */
        
        // 为空先读取数据
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
        
        // 读取文件,仍为空,则创建;
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}


#pragma mark - Navigation

// 拦截Segue,判断add还是edit;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //!!!:  取出待跳转的控制器(多态)
    UIViewController *vc = segue.destinationViewController;
    
    // 判断待跳转控制器的类型
    if ([vc isKindOfClass:[AddController class]]) {
        
        // 获取目标控制器
        AddController *ac = (AddController *)vc;
        
        // 设置当前LC为其代理
        ac.delegate = self;
        
    } else if ([vc isKindOfClass:[EditController class]]) {
        
        // 获取目标控制器
        EditController *ec = (EditController *)vc;
        
        // 获取当前点击行的模型
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        
        // 传入模型
        ec.contact = self.contacts[index.row];
        
        // 设置代理
        ec.delegate = self;
    }
}


#pragma mark - 数据源方法

// 返回Sections数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

// 返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出模型
    Contact *contact = self.contacts[indexPath.row];
    
    /*
     // 根据ID缓冲池出列复用
     NSString *reuseId = @"ID";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
     // 不存在则创建
     if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
     }
     // 设置右侧图标类型
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
     //!!!: 以上封装在自定义Cell: ContactCell的类初始化方法中;

     // 模型解析赋值
     cell.textLabel.text = contact.name;
     cell.detailTextLabel.text = contact.phone;
    
     //!!!: 以上封装在自定义Cell: ContactCell的重写setter方法中;
     */
    
    // 修改Storyboard中Cell类型为自定义Cell类文件;
    ContactCell *cell = [ContactCell contactCellWithTableView:tableView];
    
    cell.contact = contact;
    
    return cell;
}

// 数据源可选方法: 左划删除,删除提示文字,在代理方法中设置;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 如果是删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 删除操作行
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        // 全体刷新
        // [self.tableView reloadData];
        
        // 局部刷新(删除该行)
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        // 刷新存储数据
        [self writeContactsToFile];
    }
}



#pragma mark - 代理方法

// addController的代理方法
- (void)addController:(AddController *)ac withContact:(Contact *)contact {

    // 获取ac封装的对象,并存入数组
    [self.contacts addObject:contact];
    
    // 刷新数据
    [self.tableView reloadData];
    
    // 将添加后的集合存入文件
    [self writeContactsToFile];
}

// editController的代理方法
- (void)editController:(EditController *)ec {
    
    // 整体刷新
    // [self.tableView reloadData];
    
    // 获取指定行
    //!!!: (NSArray *)indexPaths, 要求传入数组;
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    
    self.contacts[index.row] = ec.contact;
    
    // 局部刷新
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationMiddle];
    
    // 将修改后的集合存入文件
    [self writeContactsToFile];
}

// 代理方法,设置删除行的提示文字(方法名:传入是tableView,返回是字符串)
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


#pragma mark - 数据存取方法

// 初始化读取数据,添加\编辑联系人存储数据;

// 文件路径
- (NSString *)filePath {
    
    // 获取Documents路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接联系人数据文件名
    path = [path stringByAppendingPathComponent:@"Contacts.data"];
    NSLog(@"%@", path);
    return path;
}

// 联系人数据存入文件
- (void)writeContactsToFile {
    
    // 获取文件路径
    NSString *filePath = [self filePath];
    
    //!!!: 归档存入文件
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:filePath];
    
    //!!!: 切记去待存储对象中, 定义对象的存(encodeWithCoder:)取(initWithCoder:)方法;
}

@end

