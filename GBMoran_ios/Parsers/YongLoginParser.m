//
//  YongLoginParser.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/20.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "YongLoginParser.h"

@implementation YongLoginParser

-(YongUserModel *)parseJson:(NSData *)data{
    NSError *error =nil;
    
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    if(error){
        NSLog(@"The parser is not working.");
    }else{
        YongUserModel *user = [[YongUserModel alloc]init];
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMsg = [jsonDic valueForKey:@"message"];
            if ([[returnMsg class] isSubclassOfClass:[NSString class]]) {
                
                user.loginReturnMessage = returnMsg;
                
                id data = [jsonDic valueForKey:@"data"];
                if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
                    id userId = [data valueForKey:@"user_id"];
                    if ([[userId class] isSubclassOfClass:[NSString class]]) {
                        user.userId = userId;
                    }
                    
                    id token = [data valueForKey:@"token"];
                    if ([[token class] isSubclassOfClass:[NSString class]]) {
                        user.token = token;
                    }
                    
                    id userName = [data valueForKey:@"user_name"];
                    if ([[userName class] isSubclassOfClass:[NSString class]]) {
                        user.username = userName;
                    }
                }
            }
        }
        
        return user;
    }
    
    return nil;
}

@end
