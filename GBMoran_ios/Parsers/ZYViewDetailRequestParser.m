//
//  ZYViewDetailRequestParser.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYViewDetailRequestParser.h"
#import "ZYViewDetailModel.h"

@implementation ZYViewDetailRequestParser

- (NSArray *)parseJson:(NSData *)data {
    NSError *error = nil;
    NSMutableArray *array = nil;

    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"JYViewDetailRequestParser");
    } else {
        if ([[jsonDic class]isSubclassOfClass:[NSDictionary class]]) {
            array = [[NSMutableArray alloc]init];
            id data = [jsonDic valueForKey:@"data"];
            for (id dic in data) {
                ZYViewDetailModel *model = [[ZYViewDetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
            }
        }
    }
    
    return array;
}

@end
