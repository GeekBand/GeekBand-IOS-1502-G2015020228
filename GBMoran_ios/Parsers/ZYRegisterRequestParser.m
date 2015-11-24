//
//  ZYRegisterRequestParser.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYRegisterRequestParser.h"
#import "YongUserModel.h"

@implementation ZYRegisterRequestParser
-(YongUserModel *)parseJson:(NSData *)data{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if(error){
        NSLog(@"The parser is not working.");
    }else{
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMsg = [jsonDic valueForKey:@"message"];
            if ([[returnMsg class] isSubclassOfClass:[NSString class]]) {
                YongUserModel *user = [[YongUserModel alloc]init];
                user.registerreturnMessage = returnMsg;
                
                return user;
            }
        }
    }
    
    return nil;
}


@end
