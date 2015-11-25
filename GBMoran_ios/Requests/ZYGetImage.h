//
//  ZYGetImage.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/25.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYGetImage : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlconnection;
@property (nonatomic,strong) NSMutableData *receiveData;

-(void)sendGettingImageRequest;

@end
