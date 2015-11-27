//
//  ZYPubilshViewController.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ZYPubilshViewController :  UIViewController <UITextViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSMutableDictionary *dic;
@property (strong, nonatomic) CLLocationManager *locationManager;
- (IBAction)touchDown:(id)sender;
@end
