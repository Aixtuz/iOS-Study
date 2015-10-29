//
//  ViewController.m
//  06-PicViewDict
//
//  Created by Aixtuz Kang on 15/5/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

// #define pic @"pic" 优点:代码有提示;缺点:无脑替换字符
#define picKey @"pic"
#define showInfoKey @"showInfo"

#import "ViewController.h"

@interface ViewController ()

// 索引
@property (assign, nonatomic) int index;
// 图片数组
@property (strong, nonatomic) NSArray *picArray; // 访问属性,注意用 _picArray 或者 self.picArray
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

// 重写get方法:懒加载(延迟加载)
- (NSArray *)picArray;

// 监听按钮
- (IBAction)changeBtn:(UIButton *)sender;

// 设置数据（图片、页码、简介、按钮状态）
- (void)changeData;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //!!!: 预加载图片,内存消耗大,改用:懒加载(延迟加载)
    /*
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[picKey] = @"biaoqingdi";
    dict1[showInfoKey] = @"在他面前,其他什么表情都若爆了！";
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    dict2[picKey] = @"bingli";
    dict2[showInfoKey] = @"这也忒狠了...";
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    dict3[picKey] = @"chiniupai";
    dict3[showInfoKey] = @"小姑娘吃个牛排比杀牛还费劲...";
    NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
    dict4[picKey] = @"danteng";
    dict4[showInfoKey] = @"亲,你能改下网名不？";
    NSMutableDictionary *dict5 = [NSMutableDictionary dictionary];
    dict5[picKey] = @"wangba";
    dict5[showInfoKey] = @"哥们为什么要选8号呢...";
    self.picArray = @[dict1, dict2, dict3, dict4, dict5];
    */
    
    // 设置初始状态
    [self changeData];
    
}

//!!!: 重写get方法:懒加载(延迟加载)
- (NSArray *)picArray {
    
    // get时,才加载
    //!!!: _picArray不用self.picArray:get方法中调用get方法,死循环;
    if (_picArray == nil) {
        
        // 创建字典存储键值对
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
        dict1[picKey] = @"biaoqingdi";
        dict1[showInfoKey] = @"在他面前,其他什么表情都若爆了！";
        NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
        dict2[picKey] = @"bingli";
        dict2[showInfoKey] = @"这也忒狠了...";
        NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
        dict3[picKey] = @"chiniupai";
        dict3[showInfoKey] = @"小姑娘吃个牛排比杀牛还费劲...";
        NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
        dict4[picKey] = @"danteng";
        dict4[showInfoKey] = @"亲,你能改下网名不？";
        NSMutableDictionary *dict5 = [NSMutableDictionary dictionary];
        dict5[picKey] = @"wangba";
        dict5[showInfoKey] = @"哥们为什么要选8号呢...";
        
        // 创建数组存储字典
        self.picArray = @[dict1, dict2, dict3, dict4, dict5];
        
    }
    
    // 返回字典数组
    return _picArray;
    
}

// 监听按钮
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

// 设置数据（图片,页码,简介,按钮状态）
- (void)changeData {
    
    // 获取字典
    NSDictionary *dict = self.picArray[self.index];
    
    // 设置图片
    //!!!: dict里存的是NSString对象，所以不是=字典value,而是=imageNamed方法返回的UIImage;
    self.pic.image = [UIImage imageNamed:dict[picKey]];
    
    // 设置页码
    self.num.text = [NSString stringWithFormat:@"%d/%ld", self.index + 1, self.picArray.count];
    
    // 设置简介
    self.showInfo.text = dict[showInfoKey]; // dict里存的就是NSString对象
    
    // 设置按钮状态
    self.left.enabled = (self.index != 0);
    self.right.enabled = (self.index != 4);
    
}

@end

