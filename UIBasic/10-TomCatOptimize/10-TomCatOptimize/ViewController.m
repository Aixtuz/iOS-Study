//
//  ViewController.m
//  10-TomCatOptimize
//
//  Created by Aixtuz Kang on 15/5/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// TomCat
@property (weak, nonatomic) IBOutlet UIImageView *tomCat;

// 执行动画
- (void)runAnimationWithName:(NSString *)name andCount:(int)count;

// drink
- (IBAction)drink;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 执行动画
//!!!: 序列帧动画封装方法,优化通用;
- (void)runAnimationWithName:(NSString *)name andCount:(int)count {
    
    // 创建可变数组存储序列动画
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        
        // 利用传入参数+count拼接出图片名
        NSString *picName = [NSString stringWithFormat:@"%@_%02d", name, i];
        
        // 加载图片
        // UIImage *img = [UIImage imageNamed:picName];
        //!!!: imageNamed: 方法，加载图片后不会释放
        
        // 利用拼接的文件名，获取文件路径
        NSString *picPath = [[NSBundle mainBundle] pathForResource:picName ofType:@"jpg"];
        
        //!!!: 通过路径加载图片,用完会释放
        UIImage *img = [UIImage imageWithContentsOfFile:picPath];
        
        // 图片存入数组
        [images addObject:img];
    }
    
    // 设置序列图片
    self.tomCat.animationImages = images;
    
    // 设置循环次数
    self.tomCat.animationRepeatCount = 1;
    
    // 设置动画时长
    self.tomCat.animationDuration = images.count * 0.1;
    
    // 动画开始
    [self.tomCat startAnimating];
    
    //!!!: 路径加载图片会释放,但属性指针强引用,不释放,手动给属性=nil;
    // 释放图片(延迟执行方法:设置nil图片)
    [self.tomCat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:images.count * 0.1];
    
}

- (IBAction)drink {
    
    // 调用执行动画，传入动画名和图片数
    [self runAnimationWithName:@"drink" andCount:81];
    
}


@end

