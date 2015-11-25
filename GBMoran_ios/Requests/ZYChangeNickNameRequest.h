//
//  ZYChangeNickNameRequest.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//


#import <Foundation/Foundation.h>
@class ZYChangeNickNameRequest;

@protocol ZYChangeNickNameRequestDelegate <NSObject>

- (void)changeNickNameRequestSuccess:(ZYChangeNickNameRequest *)request;
- (void)changeNickNameRequestFailed:(ZYChangeNickNameRequest *)request error:(NSError *)error;

@end

@interface ZYChangeNickNameRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id<ZYChangeNickNameRequestDelegate> delegate;

- (void)sendChangingNickNameRequest:(NSString *)nickName delegate:(id<ZYChangeNickNameRequestDelegate>)delegate;

@end
