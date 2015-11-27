//
//  ZYSquareRequestParser.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/20.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYSquareRequestParser.h"
#import "ZYSquareModel.h"
#import "ZYPictureModel.h"

@implementation ZYSquareRequestParser

-(NSDictionary *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (error) {
        NSLog(@"JYSquareRequestParser does not work.");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id data = [[jsonDic valueForKey:@"data"] allValues];
            for (id dic in data) {
                self.addrArray = [NSMutableArray array];
                self.pictureArrary = [NSMutableArray array];
                ZYSquareModel *squareModel = [[ZYSquareModel alloc]init];
                [squareModel setValuesForKeysWithDictionary:dic[@"node"]];
                for (id picDict in dic[@"pic"]) {
                    ZYPictureModel *picModel = [[ZYPictureModel alloc]init];
                    [picModel setValuesForKeysWithDictionary:picDict];
                    [self.pictureArrary addObject:picModel];
                }
                [self.addrArray addObject:squareModel];
                [dictionary setObject:_pictureArrary forKey:_addrArray];
            }
        }
    }
    return dictionary;
}

@end
