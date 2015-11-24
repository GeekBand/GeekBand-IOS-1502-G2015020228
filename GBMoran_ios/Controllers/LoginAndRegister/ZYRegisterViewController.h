//
//  ZYRegisterViewController.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRegisterRequest.h"

@interface ZYRegisterViewController : UIViewController<UITextFieldDelegate,ZYRegisterRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
- (IBAction)registerButtonClicked:(id)sender;
- (IBAction)loginButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerBUtton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)touchDownAction:(id)sender;

@end
