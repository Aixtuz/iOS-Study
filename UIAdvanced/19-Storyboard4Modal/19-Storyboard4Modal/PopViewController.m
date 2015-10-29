//
//  PopViewController.m
//  19-Storyboard4Modal
//
//  Created by Aixtuz Kang on 15/6/26.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController

- (IBAction)doneClick:(UIBarButtonItem *)sender {
    
    // 如果代理实现了代理方法,则调用
    if ([self.delegate respondsToSelector:@selector(closePC:withTitiel:)]){
        [self.delegate closePC:self withTitiel:@"又见面了."];
    }
    // 谁Modal谁关闭,自己调用方法,实际仍是代理调
    [self dismissViewControllerAnimated:YES completion:nil];
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
