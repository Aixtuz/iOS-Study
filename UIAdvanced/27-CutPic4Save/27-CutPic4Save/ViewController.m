//
//  ViewController.m
//  27-CutPic4Save
//
//  Created by Aixtuz Kang on 15/6/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 剪裁后的图片
@property (weak, nonatomic) IBOutlet UIImageView *picView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 监听按钮点击
- (IBAction)btnClick:(UIButton *)sender {
    
    // 原剪裁方法,矩形截取方形显示,图片变形;
    /*
     // 正方形剪裁,图片完美圆形
     // UIImage *img = [UIImage imageNamed:@"me"];
     // 非正方形剪裁,图片变形问题
     UIImage *img = [UIImage imageNamed:@"dst2"];
     
     // 开启指定的图形上下文
     UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
     
     // 获取图形上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     //上下文中绘制圆形
     CGPoint centerP = CGPointMake(img.size.width * 0.5, img.size.height * 0.5);
     CGFloat radius = MIN(img.size.width, img.size.height) * 0.5;
     CGFloat start = 0;
     CGFloat end = M_PI * 2;
     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:start endAngle:end clockwise:YES];
     
     // 路径添加到图形上下文中
     CGContextAddPath(ctx, path.CGPath);
     
     // 根据路径剪裁图形上下文(剪裁 = 线宽,颜色等,也是状态信息);
     CGContextClip(ctx);
     
     // 绘制
     [img drawAtPoint:CGPointZero];
     
     // 获取绘制号的图形(UIImage方式)
     UIImage *imgCliped = UIGraphicsGetImageFromCurrentImageContext();
     self.picView.image = imgCliped;
     
     // 结束当前上下文
     UIGraphicsEndImageContext();
     
     // UIImage保存到相册,调用的方法格式有特定要求,点击查看详细,附带contextInfo;
     UIImageWriteToSavedPhotosAlbum(imgCliped, self, @selector(image: didFinishSavingWithError: contextInfo:), @"hello");
     */
    
    //!!!: 矩形剪裁方形展示变形修复步骤
    UIImage *img = [UIImage imageNamed:@"dst2"];
    
    // 定义带边距的图形上下文区域
    CGFloat margin = 5;
    CGSize ctxSize = CGSizeMake(img.size.width + margin * 2, img.size.height + margin * 2);
    
    // 开启带边距的图形上下文
    UIGraphicsBeginImageContextWithOptions(ctxSize, NO, 0.0);
    
    // 获取此图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 根据图形上下文圆心和图片半径, 绘制最大圆环
    // 圆心
    CGPoint centerP = CGPointMake(ctxSize.width * 0.5, ctxSize.height * 0.5);
    // 半径
    CGFloat radius = MIN(img.size.width, img.size.height) * 0.5;
    // 绘制
    UIBezierPath *path0 = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    // 路径添加到图形上下文
    CGContextAddPath(ctx, path0.CGPath);

    // 设置路径颜色线宽
    [[UIColor cyanColor] setStroke];
    CGContextSetLineWidth(ctx, 5);
    
    // 渲染
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // 绘制待剪裁圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    // 添加至路径对象
    CGContextAddPath(ctx, path.CGPath);
    
    // 剪裁
    CGContextClip(ctx);
    
    //!!!: 图片绘制到上下文中,对齐中心
    [img drawAtPoint:CGPointMake(margin, margin)];
    
    
    // 获取绘制号的图形(UIImage方式)
    UIImage *imgCliped = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束当前上下文
    UIGraphicsEndImageContext();
    
    //!!!: 矩形剪裁方形
    // 定义Rect
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = 0;
    CGFloat h = (radius + 5) * 2 * scale;
    CGFloat w = h;
    CGFloat y = (ctxSize.height * scale - h) * 0.5;
    
    //!!!: 转CGImage为像素,注意1x,2x问题(*scale);
    CGImageRef cgImg = CGImageCreateWithImageInRect(imgCliped.CGImage, CGRectMake(x, y, w, h));
    
    // 赋回imgCliped
    imgCliped = [UIImage imageWithCGImage:cgImg];
    
    // 释放内存
    CFRelease(cgImg);
  
    // UIImage保存到相册,调用的方法格式有特定要求,点击查看详细,附带contextInfo;
    UIImageWriteToSavedPhotosAlbum(imgCliped, self, @selector(image: didFinishSavingWithError: contextInfo:), @"hello");
    
}

// 保存后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"===%@保存完成===", contextInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
