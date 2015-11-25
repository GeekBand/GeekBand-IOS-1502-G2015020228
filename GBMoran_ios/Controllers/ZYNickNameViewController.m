//
//  ZYNickNameViewController.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/25.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYNickNameViewController.h"
#import "ZYGlobal.h"

@interface ZYNickNameViewController ()

@end

@implementation ZYNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)changeNickNameRequestFailed:(ZYChangeNickNameRequest *)request error:(NSError *)error{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changeNickNameRequestSuccess:(ZYChangeNickNameRequest *)request{
    [ZYGlobal shareGlobal].user.username = self.nickNameTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneBarButtonClicked:(id)sender {
    ZYChangeNickNameRequest *request = [[ZYChangeNickNameRequest alloc] init];
    [request sendChangingNickNameRequest:self.nickNameTextField.text delegate:self];
}
@end
