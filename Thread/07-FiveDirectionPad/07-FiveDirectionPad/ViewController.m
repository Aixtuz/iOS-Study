//
//  ViewController.m
//  07-FiveDirectionPad
//
//  Created by Aixtuz Kang on 15/7/11.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "KCLFiveDirectionPad.h"

@interface ViewController ()

// 九宫格区域
@property (weak, nonatomic) IBOutlet UIView *fiveDirectionPad;
// 图片数组
@property (nonatomic, strong) NSArray *imageUrls;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 图片数组
    NSString *str0 = @"http://f4.topitme.com/4/a8/d1/1126643860132d1a84l.jpg";
    NSString *str1 = @"http://f10.topitme.com/o/201003/31/12699681705997.jpg";
    NSString *str2 = @"http://f10.topitme.com/o/201102/17/12979447969236.jpg";
    NSString *str3 = @"http://f10.topitme.com/l/201006/29/12777875319812.jpg";
    NSString *str4 = @"http://f10.topitme.com/l/201103/16/13002804514809.jpg";
    NSString *str5 = @"http://f10.topitme.com/o/201101/28/12962103503636.jpg";

    self.imageUrls = @[str0, str1, str2, str3, str4, str5];
    
    // 九宫格方法
    self.fiveDirectionPad = [KCLFiveDirectionPad fiveDicrectionPadView:self.fiveDirectionPad withRows:3 andCols:2 andMargin:20 byImageUrls:self.imageUrls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
