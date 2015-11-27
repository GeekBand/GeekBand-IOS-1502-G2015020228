//
//  ZYSquareRequestParser.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/20.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYSquareRequestParser : NSObject

@property (nonatomic, strong)NSMutableArray *addrArray;
@property (nonatomic, strong)NSMutableArray *pictureArrary;

- (NSDictionary *)parseJson:(NSData *)data;

@end
