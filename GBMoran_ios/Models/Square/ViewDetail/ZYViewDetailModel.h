//
//  ZYViewDetailModel.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/20.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYViewDetailModel : NSObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *modified;

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key;

@end
