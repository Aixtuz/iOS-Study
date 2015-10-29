//
//  ViewController.m
//  34-DrawingBoard
//
//  Created by Aixtuz Kang on 15/7/1.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ViewController.h"
#import "PaintView.h"
#import "PhotoView.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, PhotoViewDelegate>

// 绘制View
@property (weak, nonatomic) IBOutlet PaintView *paintView;
// Slider控件
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

// 清空
- (IBAction)clearScreen:(id)sender {
    [self.paintView clearScreen];
}

// 后退
- (IBAction)backward:(id)sender {
    [self.paintView backward];
}

// 橡皮
- (IBAction)erase:(id)sender {
    [self.paintView erase];
}


// 监听Slider的Value变化
- (IBAction)valueChange:(UISlider *)sender {
    // 监听value赋予线宽
    self.paintView.lineWidth = sender.value;
}

// 着色
- (IBAction)colorClick:(UIButton *)sender {
    self.paintView.lineColor = sender.backgroundColor;
}

// 选择照片
- (IBAction)pickPhoto:(UIBarButtonItem *)sender {
    
    // 创建选择图片的控制器
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    
    // 修改弹出时的显示类型(UIImagePickerControllerSourceTypeSavedPhotosAlbum是按照拍照时刻来选取照片的)
    imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // 设置代理(modal控制器)
    imgPicker.delegate = self;
    
    // modal出控制器
    [self presentViewController:imgPicker animated:YES completion:nil];
}

// 选择图片后的处理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // 获取选择的图片
    UIImage *photo = info[UIImagePickerControllerOriginalImage];
    
    // 根据图片创建透明的自定义View(重写初始化方法)
    PhotoView *photoView = [PhotoView photoViewWithFrame:self.paintView.frame photo:photo];
    // 设置photoView的代理
    photoView.delegate = self;
    
    // 把photoView添加到控制器的view中
    [self.view addSubview:photoView];
    
    // 关闭当前选择照片的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

// PhotoView的代理方法
- (void)photoView:(PhotoView *)photoView image:(UIImage *)image {
    
    //!!!: 为photo赋值,需重写paintView中photo的setter方法;
    self.paintView.photo = image;
    
    // 删除photoView
    [photoView removeFromSuperview];
}

// 保存到相册
- (IBAction)save:(UIBarButtonItem *)sender {
    // 开启图片的图形上下文
    UIGraphicsBeginImageContext(self.paintView.bounds.size);
    
    // 获取当前图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 把绘图View中的内容渲染到图形上下文中
    [self.paintView.layer renderInContext:ctx];
    
    // 从图形上下文中取出图片
    UIImage *imgPaint = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    // 保存图片至相册(save方法中必须实现的方法)
    UIImageWriteToSavedPhotosAlbum(imgPaint, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// 保存后必须实现的代理方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    // msg记录成功与否
    NSString *msg = @"保存成功";
    if (error != nil) {
        msg = @"保存失败!";
    }
    
    // 弹框提示
    UIAlertView *alertVw = [[UIAlertView alloc] initWithTitle:@"操作提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertVw show];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Slider的Value值赋予绘图View的线宽
    self.paintView.lineWidth = self.slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
