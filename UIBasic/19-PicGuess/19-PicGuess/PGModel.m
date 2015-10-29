//
//  PGModel.m
//  19-PicGuess
//
//  Created by Aixtuz Kang on 15/5/29.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "PGModel.h"

@implementation PGModel

//!!!: KVC字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        // self.title = dict[@"title"];
        // self.pic = dict[@"pic"];
        // self.answer = dict[@"answer"];
        // self.options = dict[@"options"];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}

// 类方法一般以类名开头
+ (instancetype)pgmodelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
    
}
@end
