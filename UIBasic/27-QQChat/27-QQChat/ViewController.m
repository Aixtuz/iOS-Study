//
//  ViewController.m
//  27-QQChat
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "MessageFrame.h"
#import "MessageCell.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

// tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

// 因Frame模型含有数据模型，故只需传递Frame模型即可
@property (strong, nonatomic) NSMutableArray *messageFrames;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // VC tableView的数据源和代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.textField.delegate = self;
    
    //!!!: 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //!!!: 设置背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //!!!: 设置cell不允许选中
    self.tableView.allowsSelection = NO;
    
    //!!!: 注册监听,实现监听通知方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //???:
    // 设置左边的view
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    // 设置左视图模式
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}


#pragma mark - 监听键盘通知方法

//!!!: 先实现通知方法,才能再viewDidLoad中注册监听,并在代理方法中监听滚动时释放键盘;
- (void) keyboardWillChangeFrameNotification:(NSNotification *) notifcation {
    
    // iOS8 在通知方法中调整键盘自带动画
    // 取出键盘结束的时候的frame
    CGRect endFrame = [notifcation.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // view的Y坐标
    CGFloat viewY = endFrame.origin.y - self.view.frame.size.height;
    
    // 设置控制器view的Y坐标
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = viewY;
    
    // 动画执行时间
    CGFloat duration = [notifcation.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 当适配iOS7时候这个动画节奏写死 7 << 16
    [UIView animateWithDuration:duration delay:0 options: 7 << 16 animations:^{
        self.view.frame = viewFrame;
    } completion:nil];
}


#pragma mark - 数据源方法

// 返回section数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 返回row数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageFrames.count;
}

// 返回cell
- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [MessageCell messageCellWithTableView:tableView];
    cell.messageFrame = self.messageFrames[indexPath.row];
    return cell;
}


#pragma mark - tableView代理方法

//!!!: 监听高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.messageFrames[indexPath.row] rowHeight];
}

//!!!: 监听滚动,释放键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - textField代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // 发送
    [self sendMessageWithContent:textField.text andWithType:MessageTypeMe];
    // 回复
    [self sendMessageWithContent:@"又在装" andWithType:MessageTypeOther];
    return YES;
}

// 发送消息方法
- (void) sendMessageWithContent:(NSString *) text andWithType:(MessageType) type {
    // 创建数据模型
    // 文本
    Message *message = [Message new];
    message.text = text;
    
    // 时间
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *nowStr = [formatter stringFromDate:now];
    message.time = nowStr;
    message.type = type;
    
    // 创建frame模型,将message赋予frame
    MessageFrame *messageFrame = [MessageFrame new];
    messageFrame.message = message;
    
    // 时间相同则隐藏
    MessageFrame *preMessageFrame = [self.messageFrames lastObject];
    //  判断
    if ([preMessageFrame.message.time isEqualToString:message.time]) {
        messageFrame.hideTime = YES;
    }
    // 添加到数组中
    [self.messageFrames addObject:messageFrame];
    
    // 刷新Cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // 滚动到最后
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    // 清空文本框
    self.textField.text = nil;
}


#pragma mark - 懒加载

- (NSMutableArray *)messageFrames {
    if (_messageFrames == nil) {
        
        // 调用模型中的加载plist方法
        NSArray *messages = [Message messages];
        
        // 创建可变Frame数组
        NSMutableArray *messageFrames = [NSMutableArray arrayWithCapacity:messages.count];
        
        // 遍历模型赋予frame模型
        for (Message *message in messages) {
            
            // 创建Frame模型
            MessageFrame *messageFrame = [[MessageFrame alloc] init];
            
            // 数据模型 赋予 Frame模型中的属性
            messageFrame.message = message;
            
            // 加入数组之前，数组最后一个元素，就是上一个元素
            MessageFrame *preMessageFrame = [messageFrames lastObject];
            
            // 重复时间隐藏
            if ([preMessageFrame.message.time isEqualToString:message.time]) {
                messageFrame.hideTime = YES;
            }
            // Frame存入数组
            [messageFrames addObject:messageFrame];
        }
        _messageFrames = messageFrames;
    }
    return _messageFrames;
}


// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
