//
//  QYHero.h
//  01- UITableView
//
//  Created by qingyun on 15/12/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYHero : NSObject


@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)heroWithDict:(NSDictionary *)dict;
@end
