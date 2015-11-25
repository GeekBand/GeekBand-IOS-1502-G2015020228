//
//  AppDelegate.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/17.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYMyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)loadMainViewWithController:(UIViewController *)controller{

    UIViewController *squarevc = [[UIViewController alloc] init];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:squarevc];
    nav1.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    nav1.tabBarItem.title = @"Square";
    nav1.tabBarItem.image = [UIImage imageNamed:@"square"];
    
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"ZYmY" bundle:[NSBundle mainBundle]];
    ZYMyViewController *myVC = [myStoryBoard instantiateViewControllerWithIdentifier:@"MyTableStoryBoard"];
    myVC.tabBarItem.title = @"My";
    myVC.tabBarItem.image = [UIImage imageNamed:@"my"];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav1,myVC];
    
[controller presentViewController:self.tabBarController animated:YES completion:nil];
//    
//    [UIView animateWithDuration:0.3 animations:^{self.l} completion:<#^(BOOL finished)completion#>]
    
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/2-60, -25, 120, 50)];
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoButton];
    
    
}

@end
