//
//  ViewController.m
//  06-ThreadCommunicate
//
//  Created by Aixtuz Kang on 15/7/11.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 新线程执行下载图片方法
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    // 就绪待命
    [thread start];
}

// 下载图片方法
- (void)downloadImage {
    
    // 模拟下载延迟
    [NSThread sleepForTimeInterval:0.5];
    // URL
    NSURL *url = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/h%3D200/sign=a4c66eccbd12c8fcabf3f1cdcc0292b4/cefc1e178a82b9019cdddfdf778da9773812efee.jpg"];
    
    // 转换二进制流
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 获取图片
    UIImage *image = [UIImage imageWithData:data];
    
    //!!!: 子线程下载, 回主线程更新UI(setImage:)
    // waitUntilDone: 是否等待调用的方法执行完毕;
    [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:YES];
}

// 设置图片方法
- (void)displayImage:(UIImage *)image {
    // 赋予属性
    self.imageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
