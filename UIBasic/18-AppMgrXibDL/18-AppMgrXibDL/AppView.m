//
//  AppView.m
//  18-AppMgrXibDL
//
//  Created by Aixtuz Kang on 15/5/28.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "AppView.h"

// 延展类
@interface AppView()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
// 传入btn或者定义btn属性监听
@property (weak, nonatomic) IBOutlet UIButton *btn;


// 监听下载按钮
- (IBAction)btnClick:(id)btn;

@end


@implementation AppView

- (void)setAppModel:(AppModel *)appModel{
    
    //???: 确保getter模型属性,数据一致;
    _appModel = appModel;
    
    // AppModel对象赋予appMdel，再用属性赋值
    self.icon.image = [UIImage imageNamed:appModel.icon];
    self.name.text = appModel.name;
    
}

// 监听下载按钮
- (IBAction)btnClick:(UIButton *)btn {
    
    // 让按钮不能点击
    btn.enabled = NO;
    
    // 创建一个用来显示信息的label
    // 创建一个label
    UILabel *pop = [[UILabel alloc] init];
    
    // 设置归属
    [self.superview addSubview:pop];
    
    // 设置frame
    CGFloat popW = 200;
    CGFloat popH = 30;
    CGFloat popX = (self.superview.frame.size.width - popW) * 0.5;
    CGFloat popY = (self.superview.frame.size.height - popH) * 0.5;
    pop.frame = CGRectMake(popX, popY, popW, popH);
    
    // 设置背景色
    pop.backgroundColor = [UIColor grayColor];
    
    //!!!: 改变透明度
    pop.alpha = 0.0;
    
    // 设置文字
    pop.text = @"正在下载...";
    // 设置文字的颜色
    pop.textColor = [UIColor whiteColor];
    // 文字居中
    pop.textAlignment = NSTextAlignmentCenter;
    
    //!!!: 圆角
    // 设置半径
    pop.layer.cornerRadius = 5;
    // 切掉多余部分
    pop.layer.masksToBounds = YES;

    //!!!: 设置动画
    // 1秒弹出
    [UIView animateWithDuration:1.0 animations:^{
        // 一秒钟透明度从0-->0.8
        pop.alpha = 0.8;
    } completion:^(BOOL finished) {
        // 弹出成功后执行: 延迟消失
        [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            // 延迟2秒,透明度1秒从0.8-->0
            pop.alpha = 0.0;
        } completion:^(BOOL finished) {
            // 完成后执行:
            [pop removeFromSuperview];
        }];
    }];
    
}

//!!!: 封装loadNibNamed:方法
+ (instancetype)loadView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
    
}

@end

