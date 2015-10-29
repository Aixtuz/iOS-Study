//
//  ViewController.m
//  22-ThreadDelegate
//
//  Created by Aixtuz Kang on 15/7/18.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "DLImageOperation.h"

@interface ViewController () <DLImageOperationDelegate>

// 非主队列
@property (nonatomic, strong) NSOperationQueue *queue;

// 图片控件
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 创建操作
    DLImageOperation *op = [[DLImageOperation alloc] init];
    
    // 设置代理
    op.delegate = self;
    
    // 操作加入队列
    [self.queue addOperation:op];
}

// 代理方法
- (void)setUpImageWithOperation:(DLImageOperation *)op {
    
    // 接收操作, 解析其中图片属性赋予控件
    self.imgView.image = op.img;
}

// 队列懒加载
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return  _queue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
