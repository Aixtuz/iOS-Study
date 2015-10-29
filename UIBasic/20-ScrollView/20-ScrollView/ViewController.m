//
//  ViewController.m
//  20-ScrollView
//
//  Created by Aixtuz Kang on 15/5/30.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

// 缩放区域
@property (weak, nonatomic) IBOutlet UIScrollView *imageZoom;
// 滚动区域
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;

// 滚动图片
@property (weak, nonatomic) IBOutlet UIImageView *image;

// 滚动按钮
- (IBAction)scrollBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 初始化
    // 获取图片原始大小
    CGFloat scrollW = self.image.frame.size.width;
    CGFloat scrollH = self.image.frame.size.height;
    
    //!!!: 设置VC为imageZoom的代理
    self.imageZoom.delegate = self;
    
    //!!!: 设置缩放参数
    self.imageZoom.minimumZoomScale = 0.5;
    self.imageZoom.maximumZoomScale = 2.0;
    
    //!!!: 设置VC为imageScroll的代理
    self.imageScroll.delegate = self;
    
    //!!!: 设置滚动范围
    self.imageScroll.contentSize = CGSizeMake(scrollW, scrollH);
    
    //!!!: 设置初始位置
    self.imageScroll.contentOffset = CGPointMake( 100, 100);
    
    //!!!: 设置滚动边距
    self.imageScroll.contentInset = UIEdgeInsetsMake(100, 50, 100, 50);

}

- (IBAction)scrollBtn {
    
    // 获取当前位置
    CGPoint offSet = self.imageScroll.contentOffset;
    
    // 变更后
    CGFloat pointX = offSet.x + 50;
    CGFloat pointY = offSet.y + 50;
    CGPoint point = CGPointMake(pointX, pointY);
    
    //!!!: 手动设置ofSet可以超出contentSize范围；
    // 重新赋值
    // self.imageScroll.contentOffset = point;
    //!!!: 带动画的赋值
    [self.imageScroll setContentOffset:point animated:YES];
}

//!!!: VC为imageScroll的代理，系统已经在协议中声明VC要监听的消息:
// 1. 监听开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"VC收到imageScroll开始拖拽的消息");
}

// 2. 监听拖拽中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    NSLog(@"拖拽中的ofSet是:%f - %f", offSet.x, offSet.y);
}

// VC为imageZoom的代理，系统已经在协议中声明VC要监听的消息
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    //!!!: imageScroll中嵌套控件时注意这里返回的子控件是谁
    return  self.imageScroll;
}

@end

