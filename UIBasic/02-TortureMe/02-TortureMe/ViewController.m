//
//  ViewController.m
//  02-TortureMe
//
//  Created by Aixtuz Kang on 15/5/23.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//!!!: IBOutlet, 属性 = 指针, 连线 = 指向, 通过指针操作对象;
// 图片
@property (weak, nonatomic) IBOutlet UIButton *photo;

//!!!: IBAction, 连线 = 监听 (默认:TouchUpInside);
// 移动
- (IBAction)move:(UIButton *)sender;

// 缩放
- (IBAction)zoom:(UIButton *)sender;

// 旋转
- (IBAction)rotate:(UIButton *)sender;

// 重置
- (IBAction)reset;

@end


@implementation ViewController

#pragma mark - frame和transform冲突？？？
//!!!: 可以直接修改OC对象中的结构体属性,但不能直接修改OC对象中结构体属性的参数;
// 正确方法: 先将结构体赋予临时变量,修改完毕,再赋回;

// 移动
- (IBAction)move:(UIButton *)sender {
    
    //!!!: 动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    //!!!: frame 实现移动
    /*
    CGRect temp = self.photo.frame;
    int maxWidth = self.view.frame.size.width - self.photo.frame.size.width;
    int maxHeight = self.view.frame.size.height - self.photo.frame.size.height;
     
    switch (sender.tag) {
        case 10:
            temp.origin.y -= 50;
            if (temp.origin.y < 0) {
                temp.origin.y = 0;
            }
            break;
        case 20:
            temp.origin.y += 50;
            if (temp.origin.y > maxHeight) {
                temp.origin.y = maxHeight;
            }
            break;
        case 30:
            temp.origin.x -= 50;
            if (temp.origin.x < 0) {
                temp.origin.x = 0;
            }
            break;
        case 40:
            temp.origin.x += 50;
            if (temp.origin.x > maxWidth) {
                temp.origin.x = maxWidth;
            }
            break;
    }
     
    self.photo.frame = temp;
    */
    
    //!!!: center 实现移动
    CGPoint temp = self.photo.center;
    int maxWidth = self.view.frame.size.width - self.photo.frame.size.width / 2;
    int maxHeight = self.view.frame.size.height - self.photo.frame.size.height / 2;
    
    switch (sender.tag) {
        case 10:
            temp.y -= 50;
            if (temp.y < self.photo.frame.size.height / 2) {
                temp.y = self.photo.frame.size.height / 2;
            }
            break;
        case 20:
            temp.y += 50;
            if (temp.y > maxHeight) {
                temp.y = maxHeight;
            }
            break;
        case 30:
            temp.x -= 50;
            if (temp.x < self.photo.frame.size.width / 2) {
                temp.x = self.photo.frame.size.width / 2;
            }
            break;
        case 40:
            temp.x += 50;
            if (temp.x > maxWidth) {
                temp.x = maxWidth;
            }
            break;
    }
    
    self.photo.center = temp;
    
    //!!!: transform 实现移动
    /*
    switch (sender.tag) {
        case 10:
            self.photo.transform = CGAffineTransformTranslate(self.photo.transform, 0, -50);
            break;
        case 20:
            self.photo.transform = CGAffineTransformTranslate(self.photo.transform, 0, 50);
            break;
        case 30:
            self.photo.transform = CGAffineTransformTranslate(self.photo.transform, -50, 0);
            break;
        case 40:
            self.photo.transform = CGAffineTransformTranslate(self.photo.transform, 50, 0);
            break;
    }
    */
    
    //!!!: 动画结束
    [UIView commitAnimations];
    
}

// 缩放
- (IBAction)zoom:(UIButton *)sender {
    
    // 动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    //!!!: frame 实现缩放
    /*
    CGRect temp = self.photo.frame;
     
    switch (sender.tag) {
        case 50:
            temp.size.width += 20;
            temp.size.height += 20;
            break;
        case 60:
            temp.size.width -= 20;
            temp.size.height -= 20;
            if (temp.size.width <= 0 || temp.size.height <= 0) {
                temp.size.width = 0;
                temp.size.height = 0;
            }
            break;
    }
     
    self.photo.frame = temp;
    */
    
    //!!!: transform 实现缩放
    switch (sender.tag) {
        case 50:
            self.photo.transform = CGAffineTransformScale(self.photo.transform, 1.2, 1.2);
            break;
        case 60:
            self.photo.transform = CGAffineTransformScale(self.photo.transform, 0.8, 0.8);
    }
    
    // 动画结束
    [UIView commitAnimations];
    
}

// 旋转
- (IBAction)rotate:(UIButton *)sender {
    
    // 动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    //!!!: transform 实现旋转
    switch (sender.tag) {
        case 70:
            self.photo.transform = CGAffineTransformRotate(self.photo.transform, - M_PI_4);
            break;
        case 80:
            self.photo.transform = CGAffineTransformRotate(self.photo.transform, M_PI_4);
            break;
    }
    
    // 动画结束
    [UIView commitAnimations];
    
}

// 重置
- (IBAction)reset {
    
    // 动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    //!!!: 清空形变
    self.photo.transform = CGAffineTransformIdentity;
    
    // 恢复位置和尺寸
    CGRect temp = self.photo.frame;
    
    temp.origin.x = 16;
    temp.origin.y = 20;
    temp.size.width = 100;
    temp.size.height = 100;
    
    self.photo.frame = temp;
    
    // 动画结束
    [UIView commitAnimations];
    
}

@end

