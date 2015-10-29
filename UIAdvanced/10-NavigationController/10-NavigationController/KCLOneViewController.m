//
//  KCLOneViewController.m
//  10-NavigationController
//
//  Created by Aixtuz Kang on 15/6/21.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "KCLOneViewController.h"
#import "KCLTwoViewController.h"

@interface KCLOneViewController ()

@end

@implementation KCLOneViewController

- (IBAction)btnClick:(UIButton *)sender {

    // 加载要跳转的控制器
    KCLTwoViewController *vc2 = [[KCLTwoViewController alloc] init];
    
    // 将此控制器入栈到导航控制器中
    [self.navigationController pushViewController:vc2 animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置当此控制器显示时,导航栏显示内容
    self.navigationItem.title = @"vc1";
    
    // 设置左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    
    // 设置右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:nil action:nil];
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
