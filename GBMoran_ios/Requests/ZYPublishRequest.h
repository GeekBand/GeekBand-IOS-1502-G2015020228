//
//  ZYPublishRequest.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZYPublishRequest;

@protocol ZYPublishRequestDelegate <NSObject>

- (void)requestSuccess:(ZYPublishRequest *)request picId:(NSString *)picId;
- (void)requestFailed:(ZYPublishRequest *)request error:(NSError *)error;

@end

@interface ZYPublishRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<ZYPublishRequestDelegate> delegate;

- (void)sendPublishRequestWithUserId:(NSString *)userId
                               token:(NSString *)token
                           longitude:(NSString *)longitude
                            latitude:(NSString *)latitude
                               title:(NSString *)title
                                data:(NSData *)data
                            location:(NSString *)location
                            delegate:(id<ZYPublishRequestDelegate>)delegate;

@end
