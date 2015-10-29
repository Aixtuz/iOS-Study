//
//  ReadAndWriteSandBox.h
//  25-SDWebImage4AppList
//
//  Created by Aixtuz Kang on 15/7/20.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ReadAndWriteSandBox : NSObject

// 获取Caches中文件路径的方法
- (NSString *)getSandboxCachesByFilename:(NSString *)filename;

// 读取沙盒文件
- (UIImage *)readImageFromSandboxByFile:(NSString *)filename;

// 写入沙盒文件
- (void)writeImage:(UIImage *)image ToSandboxFile:(NSString *)filename;

@end
