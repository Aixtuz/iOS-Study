//
//  ViewController.m
//  08-PicViewDict2Model
//
//  Created by Aixtuz Kang on 15/5/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#define picKey @"pic"
#define showInfoKey @"showInfo"

#import "ViewController.h"
#import "ImageModel.h"

@interface ViewController ()

// 索引
@property (assign, nonatomic) int index;
// 图片数组
@property (strong, nonatomic) NSArray *picArray;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *pic;
// 页码
@property (weak, nonatomic) IBOutlet UILabel *num;
// 简介
@property (weak, nonatomic) IBOutlet UITextView *showInfo;
// 左
@property (weak, nonatomic) IBOutlet UIButton *left;
// 右
@property (weak, nonatomic) IBOutlet UIButton *right;

// 重写get方法:实现懒加载（延迟加载）
- (NSArray *)picArray;

// 监听按键
- (IBAction)changeBtn:(UIButton *)sender;

// 设置数据（图片、页码、简介、按键状态）
- (void)changeData;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置初始状态
    [self changeData];
    
}

//!!!: 重写get方法:实现懒加载（延迟加载）
- (NSArray *)picArray {
    
    if (_picArray == nil) {
        
        // 获取plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"plist"];
        
        // 加载plist中的字典数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        //!!!: 字典转模型：以（字典键值-->模型属性），实现（字典的数组-->模型的数组）
        // 创建可变数组，用于存储转换的模型数组
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        // 遍历一一转换
        for (NSDictionary *dict in dictArray) {
            
            // 创建模型实例
            ImageModel *model = [[ImageModel alloc] init];
            
            // 字典键值赋予模型属性
            model.pic = dict[picKey];
            model.showInfo = dict[showInfoKey];
            
            // 模型添加到可变数组中
            [tempArray addObject:model];
            
        }
        // 可变数组赋回原数组
        _picArray = tempArray;
    }
    // 返回模型数组
    return _picArray;
}

// 监听按键
- (IBAction)changeBtn:(UIButton *)sender {
    
    // 索引变化
    switch (sender.tag) {
        case 10:
            self.index--;
            break;
        case 20:
            self.index++;
            break;
    }
    
    // 设置数据
    [self changeData];
    
}

// 设置数据（图片、页码、简介、按键状态）
- (void)changeData {
    
    // 获取模型
    ImageModel *model = self.picArray[self.index];
    
    // 设置图片
    self.pic.image = [UIImage imageNamed:model.pic]; // 注意：用imageNamed:字符串，设置图片
    
    // 设置页码
    self.num.text = [NSString stringWithFormat:@"%d/%ld", self.index + 1, self.picArray.count];
    
    // 设置简介
    self.showInfo.text = model.showInfo;
    
    // 设置按键状态
    self.left.enabled = (self.index != 0);
    self.right.enabled = (self.index != 4);
    
}

@end

