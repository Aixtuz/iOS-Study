//
//  KCLViewController.m
//  09-LazyLoad4View
//
//  Created by Aixtuz Kang on 15/6/21.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "KCLViewController.h"

@interface KCLViewController ()

@end

@implementation KCLViewController

// 重写控制器的loadView方法,
- (void)loadView {
    [super loadView];
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
