//
//  AppDelegate.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/17.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (strong, nonatomic) UIImagePickerController *pickerController;

- (void)loadMainViewWithController:(UIViewController *)controller;

@end

