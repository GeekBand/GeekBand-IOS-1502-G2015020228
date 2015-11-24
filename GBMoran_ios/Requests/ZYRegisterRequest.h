//
//  ZYRegisterRequest.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YongUserModel.h"

@class ZYRegisterRequest;

@protocol ZYRegisterRequestDelegate <NSObject>

-(void) registerRequestSuccess:(ZYRegisterRequest *)request user:(YongUserModel *)user;
-(void) registerRequestfailed:(ZYRegisterRequest *)request error:(NSError *)error;

@end


@interface ZYRegisterRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *reveiveData;

@property(nonatomic,assign) id<ZYRegisterRequestDelegate> delegate;

-(void)sendRegistWithUserName:(NSString *)username
                        email:(NSString *)email
                     password:(NSString *)password
                         gbid:(NSString *)gbid
                     delegate:(id <ZYRegisterRequestDelegate>)delegate;

@end
