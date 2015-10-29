//
//  ViewController.m
//  19-PicGuess
//
//  Created by Aixtuz Kang on 15/5/29.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "PGModel.h"

@interface ViewController ()

// 接收模型,解析赋值自身属性,属性可私有;
// 索引
@property (assign, nonatomic) int index;
// 数据
@property (strong, nonatomic) NSArray *pgData;

// 阴影
@property (weak, nonatomic) UIButton *cover;
// 分数
@property (weak, nonatomic) IBOutlet UIButton *score;
// 页码
@property (weak, nonatomic) IBOutlet UILabel *num;
// 提示信息
@property (weak, nonatomic) IBOutlet UILabel *titleTip;
// 图片
@property (weak, nonatomic) IBOutlet UIButton *pic;
// 下一题
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
// 答案区域
@property (weak, nonatomic) IBOutlet UIView *answerView;
// 选项区域
@property (weak, nonatomic) IBOutlet UIView *optionView;

// 监听图片点击
- (IBAction)imageClick;
// 监听放大按钮
- (IBAction)zoom;
// 监听下一题按钮
- (IBAction)nextClick;
// 监听提示按钮
- (IBAction)tipInfo;
// 监听帮助按钮
- (IBAction)help;

// 设置数据
- (void)changeData;
// 设置分数
- (void)changeScore:(int)delat;

// 设置答案区域
- (void)changeAnswerWithModel:(PGModel *)pgModel;
// 设置选项区域
- (void)changeOptionWithModel:(PGModel *)pgModel;

// 监听答案点击
- (void)answerClick:(UIButton *)answerBtn;
// 监听选项点击
- (void)optionClick:(UIButton *)optionBtn;

@end


@implementation ViewController

- (void)viewDidLoad {
     
     [super viewDidLoad];
     // Do any additional setup after loading the view, typically from a nib.
     
     // 设置数据
     [self changeData];
     
}

// 重写set延迟加载
- (NSArray *)pgData {
     
     if (_pgData == nil) {
          
          // 获取路径
          NSString *path = [[NSBundle mainBundle] pathForResource:@"pgData" ofType:@"plist"];
          
          // 加载plist
          NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
          
          // 创建模型数组
          NSMutableArray *modelArray = [[NSMutableArray alloc] init];
          
          // 遍历字典数组，字典转模型
          for (NSDictionary *dict in dictArray) {
               //!!!: 使用哪个类就要引用哪个头文件;
               PGModel *pgModel = [PGModel pgmodelWithDict:dict];
               [modelArray addObject:pgModel];
          }
          _pgData = modelArray;
     }
     return _pgData;
}

// 监听图片
- (IBAction)imageClick{
     
     // 屏幕尺寸
     CGFloat viewW = self.view.frame.size.width;
     CGFloat viewH = self.view.frame.size.height;
     
     // 原始图片尺寸
     CGRect rect = CGRectMake(97, 125, 180, 180);
     
     // 动画开始
     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:0.3];
     
     // 创建阴影，初始透明度0
     //!!!: initWithFrame: 带frame的初始化方法
     UIButton *cover = [[UIButton alloc] initWithFrame:self.view.frame];
     cover.alpha = 0;
     
     if (self.pic.frame.size.width == 180) {
          
          ///!!!: 绑定事件：点击阴影=点击图片
          [cover addTarget:self action:@selector(imageClick) forControlEvents:UIControlEventTouchUpInside];
          
          // 赋予属性
          self.cover = cover;
          
          //!!!: 指定插入子控件的层次：above，below，atIndex
          [self.view insertSubview:cover belowSubview:self.pic];
          
          // 设置阴影颜色
          cover.backgroundColor = [UIColor blackColor];
          
          // 设置透明度
          cover.alpha = 0.8;
          
          // 计算rect
          CGFloat bigY = (viewH - viewW) * 0.5;
          rect = CGRectMake(0, bigY, viewW, viewW);
          
          // 缩放图片
          self.pic.frame = rect;
          
     } else {
          
          //!!!: 移除阴影
          [self.cover removeFromSuperview];
          
          // 缩放图片
          self.pic.frame = rect;
          
     }
    
     // 动画提交
     [UIView commitAnimations];
    
}

// 监听放大按钮
- (IBAction)zoom {

     // 点击放大=点击图片
     [self imageClick];
     
}

// 监听下一题按钮
- (IBAction)nextClick {
     
     // 计数+1
     self.index++;
     
     // NSLog(@"当前index = %d", self.index);
     
     // 设置数据
     [self changeData];
     
     if ( self.index == 9) {

          //!!!: 最后一张设置后不可点
          self.nextBtn.enabled = NO;
         
     }
}

// 监听提示按钮
- (IBAction)tipInfo {
     
     // 提示先扣分
     [self changeScore:-1000];
     
     // 清空输入
     //!!!: forin遍历
     for (UIButton *btn in self.answerView.subviews) {
          
          // 标题文字设为空，且不可点；
          [btn setTitle:nil forState:UIControlStateNormal];
          btn.enabled = NO;
     }
     
     // 获取模型
     PGModel *pgModel = self.pgData[self.index];
     
     // 正确答案
     NSString *answer = pgModel.answer;
     
     //!!!: 取首字
     NSString *str = [answer substringToIndex:1];
     
     // 遍历选项
     for (UIButton *btn in self.optionView.subviews) {
          
          //!!!: 字符串判等,找到选项中正确首字
          if ([[btn titleForState:UIControlStateNormal] isEqualToString:str]) {
               
               // 自动点击正确首字
               [self optionClick:btn];
               
          }
     }
}

// 监听帮助按钮
- (IBAction)help {
     
     //!!!: 创建中部弹框
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你不是一个人！" message:@"分享好友，获取更多积分。"preferredStyle:UIAlertControllerStyleAlert];
     
     // 绑定中部弹框事件：确定
     [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
     
     // 绑定中部弹框事件：取消
     [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
     
     // 显示中部弹框
     [self presentViewController:alert animated:NO completion:nil];
     
}

// 设置数据
- (void)changeData {
     
     // 获取模型
     PGModel *pgModel = self.pgData[self.index];
     
     // 设置页码
     self.num.text = [NSString stringWithFormat:@"%d/%ld", self.index + 1, self.pgData.count] ;
          
     // 设置提示信息
     self.titleTip.text = pgModel.title;
          
     // 设置图片
     [self.pic setImage:[UIImage imageNamed:pgModel.pic] forState:UIControlStateNormal];
          
     // 设置答案区域
     [self changeAnswerWithModel:pgModel];
          
     // 设置选项区域
     [self changeOptionWithModel:pgModel];
     
}

// 设置分数
- (void)changeScore:(int)delat {
     
     // 获取当前分数并转整型
     int score = [[self.score titleForState:UIControlStateNormal] intValue];
     
     // 计算分数
     score += delat;
     
     // 正分显示，负分滚粗
     if (score > 0) {
          
          // 显示新分数
          [self.score setTitle:[NSString stringWithFormat:@"%d", score] forState:UIControlStateNormal];
          
     } else {
          
          // 创建中部弹框
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"抱歉！" message:@"积分不足，请努力获取更多积分。\n点击帮助另有惊喜！"  preferredStyle:UIAlertControllerStyleAlert];
          
          // 绑定中部弹框事件
          [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
          
          // 显示中部弹框
          [self presentViewController:alert animated:NO completion:nil];
          
     }
}

// 设置答案区域
- (void)changeAnswerWithModel:(PGModel *)pgModel {

     // 先清空，再设置
     for (UIButton *btn in self.answerView.subviews) {
          //!!!: 清空视图控件
          [btn removeFromSuperview];
     }
     
     //获取答案长度
     NSInteger length = pgModel.answer.length;
     //!!!: str.length: 计算个数，不区分中英文；
     /*
      NSInteger length1 = @"123".length;
      NSInteger length2 = @"一二三".length;
      NSInteger length3 = @"123一二三".length;
      NSLog(@"%ld - %ld - %ld", length1, length2, length3);
      */
     
     // 设置输入框
     for (int i = 0; i < length; i++) {
          
          // 创建输入框
          UIButton *answerBtn = [[UIButton alloc] init];
          
          // 设置归属
          [self.answerView addSubview:answerBtn];
          
          // 设置frame
          CGFloat answerViewW = self.answerView.frame.size.width;
          CGFloat answerViewH = self.answerView.frame.size.height;
          CGFloat answerSpaceX = 10;
          CGFloat answerW = 40;
          CGFloat answerH = 40;
          CGFloat answerX = (answerViewW - answerW * length - (length - 1) * answerSpaceX) * 0.5;
          CGFloat answerY = (answerViewH - answerH) * 0.5;
          answerBtn.frame = CGRectMake(answerX + (answerW + answerSpaceX) * i, answerY, answerW, answerH);
          
          // 设置背景
          [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
          [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateNormal];
          
          // 设置答案
          //!!!: 设置文字
          // [answerBtn setTitle:[pgModel.answer substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateNormal];
          
          // 设置字体颜色
          [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          
          // 绑定点击事件
          [answerBtn addTarget:self action:@selector(answerClick:) forControlEvents:UIControlEventTouchUpInside];
          
          // 初始空白不可点
          answerBtn.enabled = NO;
          
     }
}

// 设置选项区域
- (void)changeOptionWithModel:(PGModel *)pgModel {
     
     // 先清空，再设置
     for (UIButton *btn in self.optionView.subviews) {
          [btn removeFromSuperview];
     }
     
     // 设置选项
     NSInteger count = pgModel.options.count;
     for (int i = 0; i < count; i++) {
          
          // 创建输入框
          UIButton *optionBtn = [[UIButton alloc] init];
          
          // 设置归属
          [self.optionView addSubview:optionBtn];
          
          // 设置frame
          // 根据设置列数，计算行列
          int totalCol = 7;
          int totalRow = ((int)count + totalCol - 1) / totalCol;
          int row = i / totalCol;
          int col = i % totalCol;
          
          // 设置长宽+间隔
          CGFloat optionViewW = self.optionView.frame.size.width;
          CGFloat optionViewH = self.optionView.frame.size.height;
          CGFloat optionW = 40;
          CGFloat optionH = 40;
          CGFloat optionSpaceX = 10;
          CGFloat optionSpaceY = 20;
          
          // 计算边距
          CGFloat optionMarginLeft = (optionViewW - optionW * totalCol - (totalCol - 1) * optionSpaceX) * 0.5;
          CGFloat optionMarginTop = (optionViewH - optionH * totalRow - (totalRow - 1) * optionSpaceY) * 0.5;
          
          // 计算坐标
          CGFloat optionX = optionMarginLeft + (optionW + optionSpaceX) * col;
          CGFloat optionY = optionMarginTop + (optionH + optionSpaceY) * row;
          
          // 设置位置
          optionBtn.frame = CGRectMake(optionX, optionY, optionW, optionH);
          
          // 设置背景
          [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
          [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateNormal];
          
          // 设置选项
          // 设置文字
          [optionBtn setTitle:pgModel.options[i] forState:UIControlStateNormal];
          
          // 设置字体颜色
          [optionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          
          // 绑定点击事件
          [optionBtn addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
          
     }
}

// 监听答案点击
- (void)answerClick:(UIButton *)answerBtn {
     
     //!!!: 提取点击选项的文字
     NSString *answerTitle = [answerBtn titleForState:UIControlStateNormal];
     
     // 有文字返回选项，没有不可点。
     if (answerTitle == nil) {
          
          // 设置不可点
          answerBtn.enabled = NO;
          
     } else {
          
          //!!!: 遍历选项按钮
          for (UIButton *btn in self.optionView.subviews) {
               
               //!!!: 取出选项文字
               NSString *optionTitle = [btn titleForState:UIControlStateNormal];
               
               //!!!: 与点击答案相同则：
               if ([answerTitle isEqualToString:optionTitle] && btn.hidden) {
                    
                    //!!!: 清空答案文字
                    [answerBtn setTitle:nil forState:UIControlStateNormal];
                    
                    // 设置不可点
                    answerBtn.enabled = NO;
                    
                    // 恢复选项
                    btn.hidden = NO;
                    
                    // 恢复第一个就中断
                    break;
                    
               }
          }
     }
}

// 监听选项点击
- (void)optionClick:(UIButton *)optionBtn {
     
     // 提取点击选项的文字
     NSString *optionTitle = [optionBtn titleForState:UIControlStateNormal];
     
     // 遍历答案输入框
     for (UIButton *btn in self.answerView.subviews) {
          
          // 获取当前答案框文字
          NSString *answerTitle = [btn titleForState:UIControlStateNormal];
          
          // 查找第一个空白输入框
          if (answerTitle == nil) {
               
               // 选项文字赋予首个空白框
               [btn setTitle:optionTitle forState:UIControlStateNormal];
               
               btn.enabled = YES;
               
               // 点击后按键隐藏
               optionBtn.hidden = YES;
               break; // 找到空白输入后退出循环
               
          }
     }
     
     // 判断满否
     // 默认full=YES,有空才改NO
     BOOL full = YES;
     
     // 获取模型
     PGModel *pgModel = self.pgData[self.index];
     
     // 标准答案
     NSString *answer = pgModel.answer;
     
     // 遍历判断满否
     for (UIButton *btn in self.answerView.subviews) {
          
          // 获取当前答案框文字
          NSString *answerTitle = [btn titleForState:UIControlStateNormal];
          
          // 存在空白则改NO
          if (answerTitle == nil) {
               full = NO;
               break;
          }
     }
     
     // 答案校验
     if (full) {
          
          // 存储汇总
          NSMutableString *result = [[NSMutableString alloc] init];
          // 拼接输入
          for (UIButton *btn in self.answerView.subviews) {
               NSString *str = [btn titleForState:UIControlStateNormal];
               //!!!: 拼接字符串
               [result appendString:str];
          }
          
          // 判等
          if ([result isEqualToString:answer]) { //!!!: 字符串判等，不用==，用isEqualTo
               
               // 正确则字体变色
               for (UIButton *btn in self.answerView.subviews) {
                    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
               }
               
               // 分数变更
               [self changeScore:100];
               
               // 创建底部弹框
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜！" message:@"回答正确，请进入下一题。"preferredStyle:UIAlertControllerStyleActionSheet];
               
               // 绑定底部弹框事件
               [alert addAction:[UIAlertAction actionWithTitle:@"下一题" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if (self.index < 9) {
                         
                         // 前9题做完跳转下一题
                         [self nextClick];
                         
                    } else {
                         
                         // 第10题做完，弹框结束
                         // 创建中部弹框
                         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜！" message:@"完成通关，下次再见。"preferredStyle:UIAlertControllerStyleAlert];
                         
                         // 绑定中部弹框事件
                         [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                         
                         // 显示中部弹框
                         [self presentViewController:alert animated:NO completion:nil];
                         
                    }
               }]];
               
               // 显示底部弹框
               [self presentViewController:alert animated:NO completion:nil];
               
          } else {
               
               // 错误则字体变色
               for (UIButton *btn in self.answerView.subviews) {
                    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
               }
               
          }
     }
}

@end

