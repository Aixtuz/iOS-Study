//
//  MessageCell.m
//  05-QQChat
//
//  Created by Aixtuz Kang on 15/6/8.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "MessageCell.h"
#import "UIImage+KCL.h"

@interface MessageCell ()

// frame对应控件
@property (weak, nonatomic) UILabel *timeLabel;
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UIButton *textBtn;

@end


@implementation MessageCell

// 缓冲池出列 + 重写初始化方法 封装为 加载Cell的方法
+ (instancetype)messageCellWithTableView:(UITableView *)tableView {
    
    NSString *reuseId = @"message";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

// 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    // 父级初始化完毕不为空
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化子控件
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UIButton *textBtn = [[UIButton alloc] init];
        [self addSubview:textBtn];
        self.textBtn = textBtn;
        
        // 初始化中 适合放 只需执行一次的代码
        
        // 只需一次,全部时间居中,字号12
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:12];
        
        // 只需一次,全体字号textFont
        //!!!: 设置字体和Frame中计算字体区域的字号必须一致，才能正确算出所占区域大小；
        textBtn.titleLabel.font = textFont;
        
        // 只需一次,全部按钮字体黑色,并自动换行
        [textBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        textBtn.titleLabel.numberOfLines = 0;
        
        //!!!: 只需一次,清楚全部cell颜色
        self.backgroundColor = [UIColor clearColor];
        
        //!!!: 只需一次,设定全部按钮内边距
        self.textBtn.contentEdgeInsets = UIEdgeInsetsMake(textPadding, textPadding, textPadding, textPadding);
        
        //!!!: 只需一次,全部头像圆角
        iconView.layer.cornerRadius = 20;
        // iconView.clipsToBounds = YES;
        iconView.layer.masksToBounds = YES;
        
    }
    return self;
}

// 重写数据接口：frame模型的setter方法
- (void)setMessageFrame:(MessageFrame *)messageFrame {
    
    // 传入Frame数据包，先赋予自身Frame属性
    //!!!: 重写set方法中，不能调用set方法，点语法也注意避免用set
    _messageFrame = messageFrame;
    
    // 取出数据模型,设置数据
    Message *message = messageFrame.message;
    
    // 对初始化中的控件属性赋值
    self.timeLabel.text = message.time;
    
    // 重复时间
    self.timeLabel.hidden = messageFrame.isHideTime;
    
    // 图标，图标背景 需判断type
    if (message.type == MessageTypeMe) {
        
        // 设置头像
        self.iconView.image = [UIImage imageNamed:@"me"];

    
        //!!!: UIImage延展,直接封装返回可拉伸图片方法(引用头文件);
        /*
        //!!!: 可拉伸图片,先取Images.xcassets中开启拉伸
        UIImage *norImage = [UIImage imageNamed:@"chat_send_nor"];
        // 帽子
        CGFloat left = norImage.size.width * 0.5;
        CGFloat top = norImage.size.height * 0.5;
        CGFloat right = left;
        CGFloat bottom = top;
        // 方法1: (IOS5-) Stretchable
        norImage = [norImage stretchableImageWithLeftCapWidth:left topCapHeight:top];
        // 方法2: (IOS5) Resizable
        norImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
        // 方法3: (IOS6) Resizable,(Tile:平铺, Stretch:拉伸)
        norImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
        */
        
        // 设置文本背景
        [self.textBtn setBackgroundImage:[UIImage resizableImageNamed:@"chat_send_nor"] forState:UIControlStateNormal];
        [self.textBtn setBackgroundImage:[UIImage resizableImageNamed:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
        
    } else if (message.type == MessageTypeOther) {
        
        // 设置头像
        self.iconView.image = [UIImage imageNamed:@"other"];
        
        [self.textBtn setBackgroundImage:[UIImage resizableImageNamed:@"chat_recive_nor"] forState:UIControlStateNormal];
        [self.textBtn setBackgroundImage:[UIImage resizableImageNamed:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
    }
    
    // 设置文本内容
    [self.textBtn setTitle:message.text forState:UIControlStateNormal];
    
    // 取出frame，设置frame
    self.timeLabel.frame = messageFrame.timeF;
    self.iconView.frame = messageFrame.iconF;
    self.textBtn.frame = messageFrame.textF;
}

@end

