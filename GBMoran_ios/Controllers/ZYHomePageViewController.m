//
//  ZYHomePageViewController.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/26.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYHomePageViewController.h"

@interface ZYHomePageViewController ()

@end

@implementation ZYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showHomePage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showHomePage{
    [self.webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString: @"http://geekband.com"]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
