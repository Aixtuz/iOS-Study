//
//  ReadAndWriteSandBox.m
//  25-SDWebImage4AppList
//
//  Created by Aixtuz Kang on 15/7/20.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ReadAndWriteSandBox.h"

@implementation ReadAndWriteSandBox

// 获取Caches中文件路径的方法
- (NSString *)getSandboxCachesByFilename:(NSString *)filename {
    
    //!!!:  获取Caches路径: NSSearchPath方法返回数组
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    //!!!: 打印一次Caches地址
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"%@",path);
    });
    
    // 拼接文件路径
    if (filename) {
        
        // 有文件则拼接路径
        NSString *file = [path stringByAppendingPathComponent:filename.lastPathComponent];
        return file;
    } else {
        // 无文件直接返回Caches路径
        return path;
    }
}

// 读取沙盒文件
- (UIImage *)readImageFromSandboxByFile:(NSString *)filename {
    
    // 获取完整路径
    NSString *file = [self getSandboxCachesByFilename:filename];
    
    // 根据路径获取文件
    UIImage *image = [UIImage imageWithContentsOfFile:file];
    
    return image;
}

// 写入沙盒文件
- (void)writeImage:(UIImage *)image ToSandboxFile:(NSString *)filename {
    
    // 拼接完整路径
    NSString *file = [self getSandboxCachesByFilename:filename];
    
    // 文件转回二进制
    NSData *data = UIImagePNGRepresentation(image);
    
    // 写入沙盒
    [data writeToFile:file atomically:YES];
}

@end

