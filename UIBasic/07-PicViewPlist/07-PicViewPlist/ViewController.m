//
//  ViewController.m
//  07-PicViewPlist
//
//  Created by Aixtuz Kang on 15/5/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#define picKey @"pic"
#define showInfoKey @"showInfo"

#import "ViewController.h"

@interface ViewController ()

// 索引
@property (assign, nonatomic) int index;
// 图片数组
@property (strong, nonatomic) NSArray *picArray;
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

// 重写get方法:懒加载(延迟加载)
- (NSArray *)picArray;

// 监听按键
- (IBAction)changeBtn:(UIButton *)sender;

// 设置数据（图片、页码、简介、按键状态）
- (void)changeData;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置初始状态
    [self changeData];
    
}

//!!!: 重写get方法:plist懒加载(延迟加载)
- (NSArray *)picArray {
    
    if (_picArray == nil) {
        
        // 获取plist文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"images.plist" ofType:nil];
        
        // 加载plist文件中的字典数组
        _picArray = [NSArray arrayWithContentsOfFile:path];
    }
    
    // 返回字典数组
    return _picArray;
}

// 监听按键
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

// 设置数据（图片、页码、简介、按键状态）
- (void)changeData {
    
    // 获取字典
    NSDictionary *dict = self.picArray[self.index];
    
    // 设置图片
    self.pic.image = [UIImage imageNamed:dict[picKey]];
    
    // 设置页码
    self.num.text = [NSString stringWithFormat:@"%d/%ld", self.index + 1, self.picArray.count];
    
    // 设置简介
    self.showInfo.text = dict[showInfoKey];
    
    // 设置按键状态
    self.left.enabled = (self.index != 0);
    self.right.enabled = (self.index != 4);
    
}

@end

