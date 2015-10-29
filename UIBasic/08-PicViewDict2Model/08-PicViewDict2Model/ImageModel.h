//
//  imageModel.h
//  08-PicViewDict2Model
//
//  Created by Aixtuz Kang on 15/5/25.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

//!!!: 字典转模型,存储字典键值对应的模型属性;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *showInfo;

@end
