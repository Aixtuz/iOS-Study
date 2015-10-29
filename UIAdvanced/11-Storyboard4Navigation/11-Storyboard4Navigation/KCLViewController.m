//
//  KCLViewController.m
//  11-Storyboard4Navigation
//
//  Created by Aixtuz Kang on 15/6/22.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "KCLViewController.h"

@interface KCLViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleText;

@end

@implementation KCLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // 获取segue跳转指向的控制器
    UIViewController *vc = segue.destinationViewController;
    vc.navigationItem.title = self.titleText.text;
    
    //!!!: 导航控制器拖线到第一个控制器时: 设置根控制器,后续拖线才是show跳转;
}


@end
