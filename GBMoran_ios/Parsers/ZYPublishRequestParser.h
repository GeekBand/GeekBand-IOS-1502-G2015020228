//
//  ZYPublishRequestParser.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYPublishModel.h"

@interface ZYPublishRequestParser : NSObject

- (ZYPublishModel *)parseJson:(NSData *)data;

@end
