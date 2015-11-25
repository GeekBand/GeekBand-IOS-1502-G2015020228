//
//  ZYNickNameViewController.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/25.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYChangeNickNameRequest.h"

@interface ZYNickNameViewController : UIViewController<ZYChangeNickNameRequestDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nickNameTextField;
@property (nonatomic, weak) NSString *nickName;

- (IBAction)doneBarButtonClicked:(id)sender;


@end
