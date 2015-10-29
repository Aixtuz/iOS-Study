//
//  ContactGroup.m
//  29-QQContacts
//
//  Created by Aixtuz Kang on 15/6/13.
//  Copyright (c) 2015年 Aixtuz. All rights reserved.
//

#import "ContactGroup.h"
#import "Contact.h"

@implementation ContactGroup

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        // 字典转模型
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        
        // 二级字典再转模型
        for (NSDictionary *dict in self.contacts) {
            Contact *contact = [[Contact alloc] initWithDict:dict];
            [arrayM addObject:contact];
        }
        self.contacts = arrayM;
    }
    return self;
}

+ (instancetype)contactGroupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)contactGroups {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    NSArray *dictArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    // 字典转模型
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in dictArray) {
        ContactGroup *contactGroup = [[ContactGroup alloc] initWithDict:dict];
        [arrayM addObject:contactGroup];
    }
    return arrayM;
}

@end
