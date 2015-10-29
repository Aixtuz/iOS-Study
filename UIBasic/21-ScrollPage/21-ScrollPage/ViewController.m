//
//  ViewController.m
//  21-ScrollPage
//
//  Created by Aixtuz Kang on 15/5/31.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

// 滚动框架
@property (weak, nonatomic) IBOutlet UIScrollView *banner;
// 页码
@property (weak, nonatomic) IBOutlet UIPageControl *page;
// 定时器
@property (strong, nonatomic) NSTimer *timer;

- (void)next;

@end


@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 获取scrollView尺寸
    CGFloat imageW = self.banner.frame.size.width;
    CGFloat imageH = self.banner.frame.size.height;
    
    for (int i = 0; i < 5; i++) {
        
        // 获取图片
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img_0%d", i + 1]];
        
        // 设置图片
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        // 设置归属
        //!!!: 先加载视图，后加载代码，故imageView会覆盖banner
        // [self.banner addSubview:imageView];
        //!!!: 定位层次插入
        [self.banner insertSubview:imageView atIndex:0];
        
        // 设置frame
        imageView.frame = CGRectMake( imageW * i , 0, imageW, imageH);
    }
    //!!!: 轮播参数设置
    // 设置滚动范围
    self.banner.contentSize = CGSizeMake( imageW * 5, 0);
    
    //!!!: 设置滚动分页
    self.banner.pagingEnabled = YES;
    
    //!!!: 设置总页码
    self.page.numberOfPages = 5;
    
    //!!!: 设置当前页
    // self.page.currentPage = 1;
    
    // 设置VC为banner的代理,监听两种滚动消息
    //!!!: 设置代理时,不要忘记代理需要遵守协议
    self.banner.delegate = self;
    
    // 添加定时器
    [self addTimer];
}

//!!!: VC监听滚动消息,修改页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 获取当前页坐标x值
    CGFloat tempX = scrollView.contentOffset.x;
    
    // 获取视图宽度
    CGFloat imageW = self.banner.frame.size.width;
    
    // 计算页数
    //!!!: 舍去余数改四舍五入:(被除数 + 除数*0.5) / 除数;
    int i = (tempX + imageW * 0.5) / imageW;
    
    // 设置页码
    self.page.currentPage = i;
}

//!!!: VC监听拖拽开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // invalidate：使..无效
    [self.timer invalidate];
    
    // 清空之前防止定时器被提前销毁的属性引用
    self.timer = nil;
}

//!!!: VC监听拖拽结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 拖拽完成再次计时
    [self addTimer];
}

// 轮播方法
- (void)next {
    
    //!!!: 当前页
    NSInteger page = self.page.currentPage;
    
    // 实现循环
    if (page == 4) {
        page = 0;
    } else {
        page++;
    }
    
    // 设置偏移后的位置
    CGPoint offSet = CGPointMake( self.banner.frame.size.width * page, 0);
    [self.banner setContentOffset:offSet animated:YES];
}

// 添加定时器
- (void)addTimer {
    
    //!!!: 创建定时器(间隔、方法调用者、调用方法、用户信息、是否循环)
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    
    // 属性引用计时器，防止被销毁
    self.timer = timer;
    
    //!!!: 修改定时器模式，交替处理banner滚动和 TextField滚动
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

@end

