//
//  ContactGroup.h
//  29-QQContacts
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactGroup : NSObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) int online;
@property (strong, nonatomic) NSArray *contacts;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)contactGroupWithDict:(NSDictionary *)dict;

+ (NSArray *)contactGroups;

@end
