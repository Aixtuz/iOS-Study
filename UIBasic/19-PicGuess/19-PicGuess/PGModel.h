//
//  PGModel.h
//  19-PicGuess
//
//  Created by Aixtuz Kang on 15/5/29.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGModel : NSObject

//!!!: 模型属性要解析给其他类,故不能私有;
// 提示
@property (copy, nonatomic) NSString *title;
// 图片
@property (copy, nonatomic) NSString *pic;
// 答案
@property (copy, nonatomic) NSString *answer;
// 选项
@property (strong, nonatomic) NSArray *options;

// 重写init方法，字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict;

// 类方法一般以类名开头
+ (instancetype)pgmodelWithDict:(NSDictionary *)dict;

@end
