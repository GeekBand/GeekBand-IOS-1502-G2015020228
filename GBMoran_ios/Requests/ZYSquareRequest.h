//
//  ZYSquareRequest.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYSquareModel.h"

@class ZYSquareRequest;

@protocol ZYSquareRequestDelegate <NSObject>

- (void)squareRequestSuccess:(ZYSquareRequest *)request dictionary:(NSDictionary *)dictionary;
- (void)squareRequestFailed:(ZYSquareRequest *)request error:(NSError *)error;

@end

@interface ZYSquareRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<ZYSquareRequestDelegate> delegate;

- (void)sendSquareRequestWithParamter:(NSDictionary *)paramDic delegate:(id<ZYSquareRequestDelegate>)delegate;

@end
