//
//  ZYChangeNickNameRequest.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZYChangeImageRequest;

@protocol ZYChangeImageRequestDelegate<NSObject>

- (void)changeImageRequestSuccess:(ZYChangeImageRequest *)request;
- (void)changeImageRequestFailed:(ZYChangeImageRequest *)request error:(NSError *)error;

@end

@interface ZYChangeImageRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id<ZYChangeImageRequestDelegate> delegate;

- (void)sendChangingImageRequest:(UIImage *)image delegate:(id<ZYChangeImageRequestDelegate>)delegate;

@end
