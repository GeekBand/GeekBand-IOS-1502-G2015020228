//
//  ZYPubilshViewController.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYPubilshViewController.h"
#import "ZYPublishRequest.h"
#import "ZYGlobal.h"
#import "YongUserModel.h"

@interface ZYPubilshViewController () <ZYPublishRequestDelegate> {
    UILabel *titleLabel;
}

@end

@implementation ZYPubilshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [[UIColor alloc]initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc]initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    [self.navigationController.navigationBar setAlpha:1.0];
    self.textView.delegate = self;
    
    //title label
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 10, 100, 30)];
    titleLabel.text = @"发布照片";
    titleLabel.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:titleLabel];
    
    [self makePulishButton];
    [self makeBackButton];
    
    [self getLatitudeAndLongitude];
}

- (void)makePulishButton {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65, 0, 50, 40)];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.alpha = 0.8;
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishPhotoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3.0;
    button.clipsToBounds = YES;
    //    button.tintColor = [UIColor blackColor];
    //    button.titleLabel.textColor = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:button];
}

- (void)makeBackButton {
    UIButton *backButton = [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(backButtonClicked:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backButtonClicked:(id)sender {
    //    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)getLatitudeAndLongitude {
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.distanceFilter = 1000.0f;
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"定位失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.dic = [NSMutableDictionary dictionary];
    NSString *latitudeString = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    [self.dic setValue:latitudeString forKey:@"latitude"];
    [self.dic setValue:longitudeString forKey:@"longtitude"];
    CLLocationDegrees latitude = newLocation.coordinate.latitude;
    CLLocationDegrees longitude = newLocation.coordinate.longitude;
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            // TODO:
            NSString *locationLabelText = dict[@"Name"];
            
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)makeLocation {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSString *latitude = [NSString stringWithFormat:@"l=%@", [self.dic valueForKey:@"latitude"]];
        NSString *latitudeWithComma = [latitude stringByAppendingString:@"%2C"];
        NSString *args =[NSString stringWithFormat:@"%@%@", latitudeWithComma, [self.dic valueForKey:@"longitude"]];
        NSString *url = @"http://apis.baidu.com/3023/geo/address";
        [self request:url withHTTPArgs:args];
    }];
    
    [queue addOperation:operation];
}

//c5ee8b689b6ede2a9db717cc04ca48d5
- (void)request:(NSString *)httpURL withHTTPArgs:(NSString *)httpArgs {
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)publishPhotoButtonClicked {
    if ([self.textView.text isEqualToString:@"你想说的话"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"请写上你的留言"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
    } else {
        NSData *data = UIImageJPEGRepresentation(self.photoView.image, 0.00001);
        YongUserModel *user = [ZYGlobal shareGlobal].user;
        ZYPublishRequest *request = [[ZYPublishRequest alloc]init];
    }
}

-(void)requestSuccess:(ZYPublishRequest *)request picId:(NSString *)picId {
    
}

- (void)requestFailed:(ZYPublishRequest *)request error:(NSError *)error {
    
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 25) {
        [self.textView resignFirstResponder];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/25", textView.text.length];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"你想说的话"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length < 1) {
        textView.text = @"我想说的话";
    }
}

- (void)touchDown:(id)sender {
    [self.textView resignFirstResponder];
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

@end
