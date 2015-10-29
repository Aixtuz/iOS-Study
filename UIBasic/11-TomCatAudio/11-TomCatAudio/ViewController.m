//
//  ViewController.m
//  11-TomCatAudio
//
//  Created by Aixtuz Kang on 15/5/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "AVFoundation/AVFoundation.h"

@interface ViewController ()

// TomCat
@property (weak, nonatomic) IBOutlet UIImageView *tomCat;
// 播放器
@property (strong, nonatomic) AVAudioPlayer *play;

// 执行动画
- (void)runAnimationWithName:(NSString *)name andCount:(int)count;

// 播放声音
- (void)playSound:(NSString *)name;

// drink
- (IBAction)drink;

// cymbal
- (IBAction)cymbal;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 执行动画
- (void)runAnimationWithName:(NSString *)name andCount:(int)count {
    
    //!!!: 动画正在执行中，则不做操作
    if (self.tomCat.isAnimating) {
        return;
    }
    
    // 创建可变数组存储序列动画
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        
        // 拼接图片名
        NSString *picName = [NSString stringWithFormat:@"%@_%02d", name, i];
        
        // 利用图片名获取路径
        NSString *path = [[NSBundle mainBundle] pathForResource:picName ofType:@"jpg"];
        
        // 通过路径加载图片
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        
        // 图片存入数组
        [images addObject:img];
        
    }
    
    // 设置图片序列
    self.tomCat.animationImages = images;
    
    // 设置循环次数
    self.tomCat.animationRepeatCount = 1;
    
    // 设置动画时长
    self.tomCat.animationDuration = images.count * 0.1;
    
    // 动画开始
    [self.tomCat startAnimating];
    
    // 释放图片
    [self.tomCat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:images.count * 0.1];
}

// 播放声音
- (void)playSound:(NSString *)name {
    
//    此处判断，间隔或延迟处仍可触发其他声音
//    if (self.play.isPlaying) {
//        return;
//    }
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
    
    // 路径转URL
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 创建error
    NSError *error = [[NSError alloc] init];
    
    //!!!: 创建播放器
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    // 强指针引用
    self.play = player;
    
    // 播放
    [self.play play];
    
}

// drink
- (IBAction)drink {
    
    //!!!: 动画or声音进行中，禁止调用其他方法
    if (self.tomCat.isAnimating || self.play.isPlaying) {
        return;
    }
    
    // 播放动画和声音
    [self runAnimationWithName:@"drink" andCount:81];
    // [self playSound:@"pour_milk"];
    //!!!: 延迟调用方法
    [self performSelector:@selector(playSound:) withObject:@"pour_milk" afterDelay:2];
    [self performSelector:@selector(playSound:) withObject:@"p_drink_milk" afterDelay:4];
    
}

// cymbal
- (IBAction)cymbal {
    
    // 动画or声音进行中，进制调用其他方法
    if (self.tomCat.isAnimating || self.play.isPlaying) {
        return;
    }
    
    // 播放动画和声音
    [self runAnimationWithName:@"cymbal" andCount:12];
    [self performSelector:@selector(playSound:) withObject:@"cymbal" afterDelay:0.3];
    
}

@end

