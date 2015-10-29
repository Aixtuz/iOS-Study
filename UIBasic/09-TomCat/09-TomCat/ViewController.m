//
//  ViewController.m
//  09-TomCat
//
//  Created by Aixtuz Kang on 15/5/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// TomCat
@property (weak, nonatomic) IBOutlet UIImageView *tomCat;

// drink
- (IBAction)drink;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// drink
- (IBAction)drink {
    
    // 创建可变数组存储 序列动画
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i = 0; i < 81; i++) {
        
        // 获取图片名
        NSString *name = [NSString stringWithFormat:@"drink_%02d.jpg", i];
        
        // 获取图片
        UIImage *img = [UIImage imageNamed:name];
        
        // 存入可变数组
        [images addObject:img];
        
    }
    
    //!!!: 图片序列帧动画
    // 设置序列图片
    self.tomCat.animationImages = images;
    
    // 设置循环次数
    self.tomCat.animationRepeatCount = 1;
    
    // 设置动画时长
    self.tomCat.animationDuration = images.count * 0.1;
    
    // 动画开始
    [self.tomCat startAnimating];
    
}

@end

