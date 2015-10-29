//
//  ViewController.m
//  15-QueueGroup
//
//  Created by Aixtuz Kang on 15/7/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 下图
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
// 上图
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //!!!: 队列组(异步函数 + 全局并发队列)方法
    [self groupTest];
    
}

//!!!: 队列组(异步函数 + 全局并发队列)实现下载&&拼接图片
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    // __block前缀, Block内可修改
    __block UIImage *img1, *img2;
    
    // 队列组(异步函数 + 全局并发队列)中添加任务: 异步下载图片
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        // 任务: 下载图片1
        img1 = [self downloadWebImage:@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1205/25/c2/11755122_1337938898578_800x600.jpg"];
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        // 任务: 下载图片1
        img2 = [self downloadWebImage:@"http://f.hiphotos.baidu.com/image/pic/item/50da81cb39dbb6fd4f3969d00c24ab18962b37e1.jpg"];
    });
    
    // 队列组执行完毕, 通知执行后续操作
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        
        // 拼接图片
        UIImage *img = [self mergeWithImage1:img1 andImage2:img2];
        
        // 赋值
        self.imgView1.image = img;
    });
}

// 下载图片方法
- (UIImage *)downloadWebImage:(NSString *)urlstring {
    
    // 获取url
     NSURL *url = [NSURL URLWithString:urlstring];
    
    // 获取二进制流
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 设置图片
    UIImage *img = [UIImage imageWithData:data];
    
    return img;
}

// 合并图片方法
- (UIImage *)mergeWithImage1:(UIImage *)img1 andImage2:(UIImage *)img2 {
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.imgView1.bounds.size);
    
    // 绘制图片
    [img1 drawInRect:self.imgView1.bounds];
    [img2 drawInRect:CGRectMake( 50, 50, 100, 100 )];
    
    // 取出绘图赋予图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

//!!!: 队列组(异步函数 + 全局并发队列)方法
- (void)groupTest {
    
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    // 异步函数 + 全局并发队列 的任务, 加入组队列中
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        // 任务
        NSLog(@"队列组中的队列:%@, 任务1", [NSThread currentThread]);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        // 任务
        NSLog(@"队列组中的队列:%@, 任务2", [NSThread currentThread]);
    });
    
    //!!!: 队列组任务执行完毕通知后续: 全局并发队列
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组执行完毕, 队列%@执行后续任务3", [NSThread currentThread]);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
