//
//  ViewController.m
//  27-SD4AppWatch
//
//  Created by Aixtuz Kang on 15/7/21.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#define kROWS 5
#define kCols 3
#define kMARGIN 20
#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //!!!: NSSearchPath 返回的是数组
    NSLog(@"Caches路径: %@",  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject);
}

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewH = [UIScreen mainScreen].bounds.size.height;
    
    // 计算格子宽高
    CGFloat imageW = (viewW - (kCols + 1) * kMARGIN) / kCols;
    CGFloat imageH = (viewH - (kROWS + 1) * kMARGIN) / kROWS;
    NSLog(@"宽:%f, 高:%f", imageW, imageH);
    
    for (int i = 0; i < kROWS * kCols; i++) {
        
        // 计算行列
        int row = i / kCols;
        int col = i % kCols;
        
        // 计算格子坐标
        CGFloat imageX = kMARGIN + (imageW + kMARGIN) * col;
        CGFloat imageY = kMARGIN + (imageH + kMARGIN) * row;
        
        // 创建格子
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        // 格子背景
        imageView.backgroundColor = [UIColor cyanColor];
        
        // 设置格子归属
        [self.view addSubview:imageView];
        
        // 拼接URL
        NSString *urlStr = [NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%d.jpg",i];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        // SD设置图片
        [imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            // 下载进度计算
            CGFloat width = ((double)receivedSize / expectedSize) * imageW;
            // 进度条
            UIView *propress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
            // 进度条颜色
            propress.backgroundColor = [UIColor redColor];
            
            // 设置进度条归属
            [imageView addSubview:propress];
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"下载完成");
        }];
    }
}


// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

