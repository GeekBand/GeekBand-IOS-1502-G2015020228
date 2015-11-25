//
//  ZYHeadImageViewController.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/25.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYHeadImageViewController.h"
#import "ZYGlobal.h"
#import "ZYChangeImageRequest.h"

@interface ZYHeadImageViewController ()

@end

@implementation ZYHeadImageViewController

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

-(void)changeImageRequestSuccess:(ZYChangeImageRequest *)request{
    [ZYGlobal shareGlobal].user.image = self.headImage.image;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changeImageRequestFailed:(ZYChangeImageRequest *)request error:(NSError *)error{
   [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneBarbUTTONcLICKED:(id)sender {
    ZYChangeImageRequest *request = [[ZYChangeImageRequest alloc] init];
    [request sendChangingImageRequest:self.headImage.image delegate:self];
}
- (IBAction)changeHeadImageClicked:(id)sender {
}

-(void)addOrderView{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.tabBarController.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.pickerController = [[UIImagePickerController alloc] init];
    
    if(buttonIndex == 0){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera ]) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.pickerController.allowsEditing = NO;
            
            self.pickerController.delegate = self;
            [self.tabBarController presentViewController:self.parentViewController animated:YES completion:nil ];
        }
    }else if (buttonIndex  == 1){
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate = self;
        [self.tabBarController presentViewController:self.parentViewController animated:YES completion:nil ];
    }
}
- (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    CGSize imageSize = image.size;
    imageSize.height = 626;
    imageSize.width =413;
    image = [self imageWithImage:image scaleToSize:imageSize];
    
    
    if(self.pickerController.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
    
    }else{
    
    }
    

}


@end
