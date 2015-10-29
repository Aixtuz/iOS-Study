//
//  KCLTwoViewController.m
//  10-NavigationController
//
//  Created by Aixtuz Kang on 15/6/21.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "KCLTwoViewController.h"
#import "KCLThreeViewController.h"

@interface KCLTwoViewController ()

@end

@implementation KCLTwoViewController

- (IBAction)btnClick:(UIButton *)sender {
    
    // 加载要跳转的控制器
    KCLThreeViewController *vc3 = [[KCLThreeViewController alloc] init];
    
    // 将此控制器入栈到导航控制器中
    [self.navigationController pushViewController:vc3 animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 定义导航栏titleView
    UISegmentedControl *sg = [[UISegmentedControl alloc] init];
    [sg insertSegmentWithTitle:@"全选" atIndex:0 animated:YES];
    [sg insertSegmentWithTitle:@"分组" atIndex:1 animated:YES];
    sg.frame = CGRectMake(0, 0, 150, 20);
    // 赋予导航栏
    self.navigationItem.titleView = sg;
    // 设置按钮
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
    //!!!:  按钮批量加入导航栏
    self.navigationItem.rightBarButtonItems = @[item1, item2];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
