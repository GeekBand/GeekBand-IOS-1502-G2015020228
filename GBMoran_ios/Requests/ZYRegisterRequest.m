//
//  ZYRegisterRequest.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYRegisterRequest.h"
#import "BLMultipartForm.h"
#import "ZYRegisterRequestParser.h"

@implementation ZYRegisterRequest

-(void)sendRegistWithUserName:(NSString *)username email:(NSString *)email password:(NSString *)password gbid:(NSString *)gbid delegate:(id<ZYRegisterRequestDelegate>)delegate{
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/register";
    
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:username forField:@"username"];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];;
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httprespnse= (NSHTTPURLResponse *)response;
    if(httprespnse.statusCode  == 200){
        self.reveiveData = [NSMutableData data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.reveiveData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *string = [[NSString alloc]initWithData:self.reveiveData encoding:NSUTF8StringEncoding ];
    NSLog(@"receive data string : %@",string);
    
    ZYRegisterRequestParser *parser = [[ZYRegisterRequestParser alloc] init];
    YongUserModel *user = [parser parseJson:self.reveiveData];
    if ([_delegate respondsToSelector:@selector(registerRequestSuccess:user:)]) {
        [_delegate registerRequestSuccess:self user:user];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(registerRequestfailed:error:)]) {
        [_delegate registerRequestfailed:self error:error];
    }
}

@end
