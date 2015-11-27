//
//  ZYViewDetailRequest.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZYViewDetailRequest;

@protocol ZYViewDetailRequestDelegate <NSObject>

- (void)viewDetailRequestSuccess:(ZYViewDetailRequest *)request data:(NSArray *)data;
- (void)viewDetailRequestFailed:(ZYViewDetailRequest *)request error:(NSError *)error;

@end

@interface ZYViewDetailRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<ZYViewDetailRequestDelegate> delegate;

- (void)sendViewDetailRequest:(NSDictionary *)paramDic delegate:(id<ZYViewDetailRequestDelegate>) delegate;

@end
