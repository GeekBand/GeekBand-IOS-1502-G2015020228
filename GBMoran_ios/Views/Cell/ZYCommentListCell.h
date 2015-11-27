//
//  ZYCommentListCell.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYCommentListCell : UITableViewCell

@property (nonatomic, retain) UILabel *userNameOfComment;
@property (nonatomic, retain) UILabel *textOfComment;
@property (nonatomic, retain) UIImageView *headImageOfComment;
@property (nonatomic, retain) UILabel *dateOfComment;

@end
