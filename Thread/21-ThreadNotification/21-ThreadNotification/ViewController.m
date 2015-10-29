//
//  ViewController.m
//  21-ThreadNotification
//
//  Created by Aixtuz Kang on 15/7/17.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "DLImageOperation.h"

@interface ViewController ()

// 非主队列
@property (nonatomic, strong) NSOperationQueue *queue;
// 控件
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册通知观察者, 收到通知调用setUpImageWithNotify
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpImageWithNotify:) name:@"DLImageOperation" object:nil];
}

// 定义收到通知后的操作
- (void)setUpImageWithNotify:(NSNotification *)notify {
    
    // 接收通知中传递的操作
    DLImageOperation *op = notify.object;
    
    // 解析操作的图片属性
    self.imgView.image = op.img;
}

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 创建操作
    DLImageOperation *op = [[DLImageOperation alloc] init];
    
    // 启动
    [self.queue addOperation:op];
}

// 队列懒加载
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

// 销毁时移除通知观察者(self)
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
