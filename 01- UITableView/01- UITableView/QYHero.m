//
//  QYHero.m
//  01- UITableView
//
//  Created by qingyun on 15/12/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYHero.h"

@implementation QYHero

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)heroWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
