//
//  ViewController.m
//  29-QQContacts
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "ContactGroup.h"
#import "Contact.h"
#import "HeaderView.h"

@interface ViewController ()

// 组模型属性,用于懒加载
@property (strong, nonatomic) NSArray *contactGroups;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 完成模型+懒加载后,测试模型数据;
    /*
     [ContactGroup contactGroups];
     NSLog(@"%@", self.contactGroups);
     ContactGroup *group = self.contactGroups[0];
     NSLog(@"%@", group.contacts);
     */
    
}


# pragma mark - 代理方法

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NSString *reuseId = @"header";
    HeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (headerView == nil) {
        headerView = [[HeaderView alloc] initWithReuseIdentifier:reuseId];
    }
    headerView.contactGroup = self.contactGroups[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}


#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.contactGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ContactGroup *contactGroup = self.contactGroups[section];
    return contactGroup.contacts.count;
}

//!!!: 封装Cell加载方法(缓冲池出列 + 重写初始化)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 缓冲池出列
    NSString *reuseId = @"contact";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    // 重写初始化
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    // 取出模型
    ContactGroup *contactGroup = self.contactGroups[indexPath.section];
    Contact *contact = contactGroup.contacts[indexPath.row];
        
    // 控件赋值
    cell.imageView.image = [UIImage imageNamed:contact.icon];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.intro;
    return cell;
}


#pragma mark - 懒加载

- (NSArray *)contactGroups {
    if (_contactGroups == nil) {
        _contactGroups = [ContactGroup contactGroups];
    }
    return _contactGroups;
}


#pragma mark - 隐藏状态栏

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

