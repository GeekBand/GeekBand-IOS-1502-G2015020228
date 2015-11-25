//
//  ZYGlobal.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//
#import "ZYGlobal.h"

static ZYGlobal *global = nil;

@implementation ZYGlobal

+ (ZYGlobal *)shareGlobal {
    if (global == nil) {
        global = [[ZYGlobal alloc]init];
    }
    return global;
}

@end
