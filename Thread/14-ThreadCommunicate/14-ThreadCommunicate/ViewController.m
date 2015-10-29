//
//  ViewController.m
//  14-ThreadCommunicate
//
//  Created by Aixtuz Kang on 15/7/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 按钮属性
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 监听触控
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //!!!: 常规下载图片, 按钮上显示
    /*
     NSURL *url = [NSURL URLWithString:@"http://pica.nipic.com/2007-11-09/2007119124513598_2.jpg"];
     NSData *data = [NSData dataWithContentsOfURL:url];
     UIImage *img = [UIImage imageWithData:data];
     [self.btn setBackgroundImage:img forState:UIControlStateNormal];
     */
    
    //!!!: 错误方法
    // [self downloadImage];
    
    //!!!: 异步下载图片方法
    [self setImage];

}

//!!!: 错误: 不同线程, 同时执行任务
- (void)downloadImage {
    
    // 加__block前缀, 可在block中修改
    __block UIImage *img;
    
    // 异步函数 + 全局并发队列: 下载图片
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://pica.nipic.com/2007-11-09/2007119124513598_2.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        img = [UIImage imageWithData:data];
    });
    
    // 异步函数 + 主队列: 设置图片
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.btn setImage:img forState:UIControlStateNormal];
    });
}

//!!!: 异步下载图片方法
- (void)setImage {
    
    // 异步函数 + 全局并发队列: 下载图片
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://pica.nipic.com/2007-11-09/2007119124513598_2.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        
        // 异步函数 + 主队列: 设置图片
        dispatch_async(dispatch_get_main_queue(), ^{
            // [self.btn setBackgroundImage:img forState:UIControlStateNormal];
            [self.btn setImage:img forState:UIControlStateNormal];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
