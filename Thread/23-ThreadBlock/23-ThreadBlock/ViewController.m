//
//  ViewController.m
//  23-ThreadBlock
//
//  Created by Aixtuz Kang on 15/7/18.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "DLImageOperation.h"

@interface ViewController ()

// 非主队列
@property (nonatomic, strong) NSOperationQueue *queue;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 监听触控
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 创建操作
    DLImageOperation *op = [[DLImageOperation alloc] init];
    
    //!!!: self.queue强引用op, block中要用弱引用self
    __block typeof(self)weakSelf = self;
    
    // ^(){}作为参数blk传入setUpImageWithBlock方法;
    [op setUpImageWithBlock:^(UIImage *img) {
        weakSelf.imgView.image = img;
    }];
    
    // 操作加入队列
    [self.queue addOperation:op];
}

// 懒加载
- (NSOperationQueue *)queue {
    
    // 为空才加载
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.queue cancelAllOperations];
}

@end
