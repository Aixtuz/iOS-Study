//
//  MicroBlogViewCell.m
//  26-MicroBlog
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MicroBlogViewCell.h"

// 宏定义设定 name和text的字体大小
#define nameFont [UIFont systemFontOfSize:18]
#define textFont [UIFont systemFontOfSize:14]

@interface MicroBlogViewCell ()

// 模型属性接收数据包，解析后内部赋值属性，可为私有,控件军用weak属性
// 头像
@property (weak, nonatomic) UIImageView *iconView;
// 昵称
@property (weak, nonatomic) UILabel *nameLabel;
// Vip
@property (weak, nonatomic) UIImageView *vipView;
// 文本
@property (weak, nonatomic) UILabel *textView;
// 图片
@property (weak, nonatomic) UIImageView *picView;

@end


@implementation MicroBlogViewCell

// (缓冲池出列 + 加载新Cell)封装为构造方法
//!!!: 重写构造方法，记得用instancetype返回类型
+ (instancetype)microBlogWithTableView:(UITableView *)tableView {
    
    // 定义标识符
    NSString *reuseId = @"KCL";
    
    // 先从缓冲池出列
    MicroBlogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    // 缓冲出列为空，则加载新cell
    if (cell == nil) {
        
        // 调用重写后的初始化方法
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

// 重写初始化方法：完成创建控件，设置控件为contentView的子控件,
//!!!: 重写构造方法，记得用instancetype返回类型
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    // 重写初始化步骤：1.父级初始化不为空，2.初始化自身元素；2. 让cell定义的私有属性拥有该子控件
    //!!!: 定义的子控件只在此代码块范围可通过指针操作，让属性拥有该子控件，则其他类中均可创建此对象，通过对象的属性去访问或者赋值；之后的setter方法，就是通过对象的属性为控件赋值；
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 头像
        //!!!: 1. 新建控件 设置为 contentView的子控件，可整体配合编辑模式右移；
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        //!!!: 2. 让cell定义的私有属性拥有该子控件
        self.iconView = iconView;
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        // Vip
        UIImageView *vipView = [[UIImageView alloc] init];
        [self.contentView addSubview:vipView];
        self.vipView = vipView;
        // 文本
        UILabel *textView = [[UILabel alloc] init];
        [self.contentView addSubview:textView];
        self.textView = textView;
        // 图片
        UIImageView *picView = [[UIImageView alloc] init];
        [self.contentView addSubview:picView];
        self.picView = picView;
        
        // 初始化只进行一次，故执行一次的代码可以放在这里，每次加载Cell都执行的，可以放在刷新数据的地方；
        
        // VIP: 只需设置一次，以后通过BOOL判断显示隐藏，故可写在初始化里;
        self.vipView.image = [UIImage imageNamed:@"vip"];
        
        // 设置name和text的字体大小，text允许换行
        self.nameLabel.font = nameFont;
        self.textView.font = textFont;
        self.textView.numberOfLines = 0;
    }
    return self;
}

//!!!: frame模型中包含数据模型，直接将setter方法拆分成 设置frame 和 设置 数据；
/*
 // 重写setter方法
 //!!!: 传入的数据模型，先赋值给cell的模型属性(以后通过getter方法刷新数据，需要读取_microBlog，故需要将传入的数据模型，先赋值给它)，然后通过传入的数据包(此例用数据包赋值)，或者模型属性，为其所拥有的属性对应的控件赋值；
 - (void)setMicroBlog:(MicroBlog *)microBlog
 {
 //  0.先给cell拥有的模型属性赋值
 _microBlog = microBlog;
 
 //  1.再给子控件赋值
 //!!!: 子控件数据无变化，仅仅有显示or隐藏的区别，可在上述初始化方法中赋值，提高性能；
 // 头像
 self.iconView.image = [UIImage imageNamed:microBlog.icon];
 // 昵称
 self.nameLabel.text = microBlog.name;
 // VIP: 只需设置一次，以后通过BOOL判断显示隐藏，故可写在初始化里;
 // self.vipView.image = [UIImage imageNamed:@"vip"];
 // 文本
 self.textView.text = microBlog.text;
 // 图片
 self.picView.image = [UIImage imageNamed:microBlog.pic];
 
 //!!!: 设置frame封装进frame模型里
 //  2.设置frame(拆去数据模型里)
 }
 */

// 1. 设置frame
- (void) setMicroBlogFrame:(MicroBlogFrame *)microBlogFrame {
    //  给本方法成员变量赋值
    _microBlogFrame = microBlogFrame;
    
    //  给自控设置数据
    [self setDataForSubviews];
    
    //  给子控件的frame赋值
    self.iconView.frame = microBlogFrame.iconF;
    self.nameLabel.frame = microBlogFrame.nameF;
    self.vipView.frame = microBlogFrame.vipF;
    self.textView.frame = microBlogFrame.textF;
    self.picView.frame = microBlogFrame.picF;
}

// 2. 设置数据
- (void)setDataForSubviews {
    //  1.给本方法对应的成员变量赋值
    MicroBlog *microBlog = self.microBlogFrame.microBlog;
    
    //  2.给子控件赋值
    self.iconView.image = [UIImage imageNamed:microBlog.icon];
    self.nameLabel.text = microBlog.name;
    self.vipView.hidden = !microBlog.isVip;
    self.textView.text = microBlog.text;
    if (microBlog.pic) {
        self.picView.image = [UIImage imageNamed:microBlog.pic];
        self.picView.hidden = NO;
    }else{
        self.picView.hidden = YES;
    }
    
}

@end
