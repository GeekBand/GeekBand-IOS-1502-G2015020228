//
//  ZYRegisterViewController.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYRegisterViewController.h"
#import "ZYRegisterRequest.h"

@implementation ZYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.registerBUtton.layer.cornerRadius = 5.0;
    self.registerBUtton.clipsToBounds = YES;
    self.registerBUtton.backgroundColor = [UIColor orangeColor];
    
    self.emailTextField.delegate = self;
    self.passwordTextfield.delegate = self;
    self.repeatPasswordTextField.delegate = self;
    
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

-(BOOL) isValidateEmail:(NSString *)email{
//    NSString *emailRegex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
    
    NSString *emailRegex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL) isValidatePassword:(NSString *)password{
    NSString *passwordRegex = @"[A-Z0-9a-z]{6,20}+$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

-(void)showErrorMessage:(NSString *)msg{

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

-(void)registerHandle{
    NSString *userName = self.userNameTextFIeld.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextfield.text;
    NSString *gbid =@"G2015020228";
    
    self.registerRequest = [[ZYRegisterRequest alloc]init];
    [self.registerRequest sendRegistWithUserName:userName email:email password:password gbid:gbid delegate:self];
}


- (IBAction)registerButtonClicked:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextfield.text;
    NSString *REPEATpASSWORD = self.repeatPasswordTextField.text;
    NSString *userName = self.userNameTextFIeld.text;
    
    if ([email length] == 0 || [password length] == 0 ||[REPEATpASSWORD length] ==0 || [userName length] == 0) {
        [self showErrorMessage:@"user name and email and password can not be empty."];
    }else if (![self isValidateEmail:email]){
      [self showErrorMessage:@"invalidate email adderss"];
    }else if (![password  isEqualToString:REPEATpASSWORD]){
        [self showErrorMessage:@"password inconsistent."];
    }else if (![self isValidatePassword:password]){
        [self showErrorMessage:@"invaldate password"];
    }else{
        [self registerHandle];
    }
}

- (IBAction)loginButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = self.registerBUtton.frame;
    int offest = frame.origin.y + 36 - (self.view.frame.size.height - 216);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if(offest>0){
        self.view.frame = CGRectMake(0, -offest, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (IBAction)touchDownAction:(id)sender {
    [self.userNameTextFIeld resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [self.repeatPasswordTextField resignFirstResponder];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)registerRequestfailed:(ZYRegisterRequest *)request error:(NSError *)error{
    NSLog(@"register failed: %@",error);
}

-(void)registerRequestSuccess:(ZYRegisterRequest *)request user:(YongUserModel *)user{
    if ([user.registerreturnMessage isEqualToString:@"Register success"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Register successfully. please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
@end
