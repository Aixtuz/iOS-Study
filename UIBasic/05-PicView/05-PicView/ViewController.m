//
//  ViewController.m
//  05-PicView
//
//  Created by Aixtuz Kang on 15/5/24.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 索引
@property (assign, nonatomic) int index;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *pic;
// 页码
@property (weak, nonatomic) IBOutlet UILabel *num;
// 简介
@property (weak, nonatomic) IBOutlet UITextView *showInfo;
// 左
@property (weak, nonatomic) IBOutlet UIButton *left;
// 右
@property (weak, nonatomic) IBOutlet UIButton *right;

// 监听按钮
- (IBAction)changeBtn:(UIButton *)sender;

// 设置数据（图片，页码，简介，按钮状态）
- (void)changeData;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置初始状态
    [self changeData];
    
}

//!!!: tag区分监听
- (IBAction)changeBtn:(UIButton *)sender {
    
    // 索引变化
    switch (sender.tag) {
        case 10:
            self.index--;
            break;
        case 20:
            self.index++;
            break;
    }
    
    // 设置数据
    [self changeData];
    
}

// 设置数据（图片，页码，简介，按钮状态）
- (void)changeData {
    
    //!!!: 设置图片
    switch (self.index) {
        case 0:
            // [self.pic setImage:[UIImage imageNamed:@"biaoqingdi"]];
            self.pic.image = [UIImage imageNamed:@"biaoqingdi"];
            break;
        case 1:
            // [self.pic setImage:[UIImage imageNamed:@"bingli"]];
            self.pic.image = [UIImage imageNamed:@"bingli"];
            break;
        case 2:
            // [self.pic setImage:[UIImage imageNamed:@"chiniupai"]];
            self.pic.image = [UIImage imageNamed:@"chiniupai"];
            break;
        case 3:
            // [self.pic setImage:[UIImage imageNamed:@"danteng"]];
            self.pic.image = [UIImage imageNamed:@"danteng"];
            break;
        case 4:
            // [self.pic setImage:[UIImage imageNamed:@"wangba"]];
            self.pic.image = [UIImage imageNamed:@"wangba"];
            break;
    }
    
    // 设置页码
    [self.num setText:[NSString stringWithFormat:@"%d/%d", self.index + 1, 5]];
    
    // 设置内容
    [self.showInfo setText:[NSString stringWithFormat:@"我是第%d张图片，我说我能换行，就问你怕不怕！", self.index + 1]];
    
    //!!!: 设置按钮状态
    self.left.enabled = (self.index != 0);
    self.right.enabled = (self.index != 4);
    
}

@end

