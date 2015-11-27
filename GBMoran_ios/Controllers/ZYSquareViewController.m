//
//  ZYSquareViewController.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/26.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYSquareViewController.h"
#import "ZYGlobal.h"
#import "ZYSquareCell.h"
#import "MJRefresh.h"
#import "KxMenu.h"
#import "ZYDetailViewController.h"

@interface ZYSquareViewController ()

@end

@implementation ZYSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationDic = [NSMutableDictionary dictionary];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误"
                                                       message:@"定位错误"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"取消", nil];
        [alert show];
    }
    
    // NavigationBar
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    self.titleButton.frame = CGRectMake(0, 0, 200, 35);
    [self.titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 133, 0, 0);
    self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    self.navigationItem.titleView = self.titleButton;
    
    // tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
        });
    }];
    self.tableView.header.automaticallyChangeAlpha = YES;
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.footer endRefreshing];
        });
    }];
    
    
    [self requestAlldata];
}

-(void)titleButtonClicked:(UIButton *)button{
    NSArray *menuItems = @[
                           [KxMenuItem menuItem:@"显示全部"
                                          image:nil
                                         target:self
                                         action:@selector(requestAlldata)],
                           [KxMenuItem menuItem:@"附近500米"
                                          image:nil
                                         target:self
                                         action:@selector(request500kilometerData)],
                           [KxMenuItem menuItem:@"附近1000米"
                                          image:nil
                                         target:self
                                         action:@selector(request1000kilometerData)],
                           
                           [KxMenuItem menuItem:@"附近1500米"
                                          image:nil
                                         target:self
                                         action:@selector(request1500kilometerData)],
                           ];
    
    UIButton *btn = (UIButton *)button;
    CGRect editImageFrame = btn.frame;
    UIView *targetSuperView = btn.superview;
    CGRect rect = [targetSuperView convertRect:editImageFrame toView:[[UIApplication sharedApplication] keyWindow]];
    
    [KxMenu showMenuInView:[[UIApplication sharedApplication] keyWindow] fromRect:rect menuItems:menuItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestAlldata{
    NSDictionary *dic = @{@"user_id":[ZYGlobal shareGlobal].user.userId, @"token":[ZYGlobal shareGlobal].user.token,
                          @"longitude":@"121.47794",
                          @"latitude":@"31.22516",
                          @"distance":@"1000"};
    
    ZYSquareRequest *request = [[ZYSquareRequest alloc]init];
    [request sendSquareRequestWithParamter:dic delegate:self];
}

-(void)squareRequestFailed:(ZYSquareRequest *)request error:(NSError *)error{

}

-(void)squareRequestSuccess:(ZYSquareRequest *)request dictionary:(NSDictionary *)dictionary{
    self.addrArray = [NSMutableArray arrayWithArray:[dictionary allKeys]];
    self.dataDic = dictionary;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"addrArray: %zd",self.addrArray.count);
    return self.addrArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"squareCell" forIndexPath:indexPath];
    if(!cell){
        cell = [[ZYSquareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"squareCell"];
    }
    
    ZYSquareModel *model = self.addrArray[indexPath.row][0];
    cell.squareVC = self;
    cell.locationLabel.text = model.addr;
    cell.dataArr  = self.dataDic[self.addrArray[indexPath.row]];
    cell.collectionView.delegate = cell;
    cell.collectionView.dataSource = cell;
    [cell.collectionView reloadData];
    return cell;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.locationDic = [NSMutableDictionary dictionary];
    NSString *latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    [self.locationDic setValue:latitude forKey:@"latitude"];
    [self.locationDic setValue:longitude forKey:@"longitude"];
    
    CLLocationDegrees latitude2 = newLocation.coordinate.latitude;
    CLLocationDegrees longitude2 = newLocation.coordinate.longitude;
    
    CLLocation *c = [[CLLocation alloc]initWithLatitude:latitude2 longitude:longitude2];
    CLGeocoder *revGeo = [[CLGeocoder alloc]init];
    [revGeo reverseGeocodeLocation:c completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            NSLog(@"Street address %@", [dict objectForKey:@"Street"]);
            [self.locationDic setValue:dict[@"Name"] forKey:@"location"];
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)request500kilometerData {
    NSDictionary *paramDic = @{@"user_id":[ZYGlobal shareGlobal].user.userId, @"token":[ZYGlobal shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"500"};
    ZYSquareRequest *squareRequest = [[ZYSquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParamter:paramDic delegate:self];
}

- (void)request1000kilometerData {
    NSDictionary *paramDic = @{@"user_id":[ZYGlobal shareGlobal].user.userId, @"token":[ZYGlobal shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"1000"};
    ZYSquareRequest *squareRequest = [[ZYSquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParamter:paramDic delegate:self];
}

- (void)request1500kilometerData {
    NSDictionary *paramDic = @{@"user_id":[ZYGlobal shareGlobal].user.userId, @"token":[ZYGlobal shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"1500"};
    ZYSquareRequest *squareRequest = [[ZYSquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParamter:paramDic delegate:self];
}

- (void)toCheckPicture {
    UIStoryboard *detailStoryboard = [UIStoryboard storyboardWithName:@"ZYViewDetail" bundle:[NSBundle mainBundle]];
    ZYDetailViewController *detailVC = [detailStoryboard instantiateViewControllerWithIdentifier:@"ViewDetail"];
    detailVC.pic_id = self.pic_id;
    detailVC.pic_url = self.pic_url;
    [self.navigationController pushViewController:detailVC animated:YES];
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
