//
//  ZYHeadImageViewController.h
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/25.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYChangeImageRequest.h"

@interface ZYHeadImageViewController : UIViewController<ZYChangeImageRequestDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
- (IBAction)doneBarbUTTONcLICKED:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
- (IBAction)changeHeadImageClicked:(id)sender;

@property (nonatomic, strong) UIImagePickerController *pickerController;

@end
