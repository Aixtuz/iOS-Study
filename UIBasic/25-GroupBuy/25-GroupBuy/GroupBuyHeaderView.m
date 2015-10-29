//
//  GroupBuyHeaderView.m
//  25-GroupBuy
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "GroupBuyHeaderView.h"

@interface GroupBuyHeaderView () <UIScrollViewDelegate>

// 轮播器
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// 页码
@property (weak, nonatomic) IBOutlet UIPageControl *page;
// 计时器
@property (strong, nonatomic) NSTimer *timer;

// 轮播方法
- (void)next;

@end


@implementation GroupBuyHeaderView

// 加载Xib方法
+ (instancetype) groupBuyHeaderView {
    
    //!!!: 注意 加载Xib方法 返回的是 数组；
    return [[[NSBundle mainBundle] loadNibNamed:@"GroupBuyHeaderView" owner:nil options:nil] firstObject];;
}

- (void)awakeFromNib {
    
    // 获取scrollView尺寸，用于赋予图片
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    
    //遍历页数
    int count = 5;
    for (int i = 0; i < count; i++) {
        
        // 拼接图片名
        NSString *imageName = [NSString stringWithFormat:@"ad_0%d", i];
        
        // 获取图片
        UIImage *image = [UIImage imageNamed:imageName];
        
        // 新建imageView控件
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        // 设置归属:imageView控件插入ScrollView之下
        [self.scrollView insertSubview:imageView atIndex:0];
        
        imageView.frame = CGRectMake(imageW * i, 0, imageW,imageH);
    }
    
    // 设置滚动范围
    self.scrollView.contentSize = CGSizeMake(imageW * count, 0);
    
    // 启用分页
    self.scrollView.pagingEnabled = YES;
    
    // 设置页码总数
    self.page.numberOfPages = 5;
    
    // 增加计时器,定时调用next;
    [self addTimer];
}

// 添加定时器
- (void)addTimer {
    
    // 创建定时器(间隔、方法调用者、调用方法、用户信息、是否循环)
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    
    // 属性引用计时器，防止被销毁
    self.timer = timer;
    
    // 修改定时器模式，交替处理banner滚动和 TextField滚动
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 轮播方法
- (void)next {
    
    // 当前页
    NSInteger page = self.page.currentPage;
    
    // 实现循环
    if (page == 4) {
        page = 0;
    } else {
        page++;
    }
    
    // 设置偏移后的位置
    CGPoint offSet = CGPointMake( self.scrollView.frame.size.width * page, 0);
    [self.scrollView setContentOffset:offSet animated:YES];
}

// 监听滚动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 开始滚动设置计时器无效
    [self.timer invalidate];
    
    // 并清空计时器属性的指针
    self.timer = nil;
}

// VC监听滚动消息,修改页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 获取当前页坐标x值
    CGFloat tempX = scrollView.contentOffset.x;
    
    // 获取视图宽度
    CGFloat imageW = self.scrollView.frame.size.width;
    
    // 计算页数
    //!!!: 舍去余数改四舍五入:(被除数 + 除数*0.5) / 除数;
    int i = (tempX + imageW * 0.5) / imageW;
    
    // 设置当前页码
    self.page.currentPage = i;
}

// 监听滚动结束: 再次增加计时器方法;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 拖拽完成再次计时
    [self addTimer];
}

@end
