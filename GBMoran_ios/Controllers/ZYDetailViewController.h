//
//  ZYDetailViewController.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYViewDetailRequest.h"

@interface ZYDetailViewController :UIViewController<UITableViewDataSource, UITableViewDelegate,ZYViewDetailRequestDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (nonatomic, copy) NSString *pic_id;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSArray *commentArrary;


@end
