//
//  ZYPublishRequestParser.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYPublishRequestParser.h"

@implementation ZYPublishRequestParser

- (ZYPublishModel *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"Error in JYPublishRequestParser");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"data"];
            id returnPic = [returnMessage valueForKey:@"pic_id"];
            if ([[returnPic class] isSubclassOfClass:[NSString class]]) {
                ZYPublishModel *model = [[ZYPublishModel alloc]init];
                model.picId = returnPic;
                return model;
            }
        }
    }
    
    return nil;
}

@end
