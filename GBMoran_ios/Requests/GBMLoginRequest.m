//
//  GBMLoginRequest.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/18.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "GBMLoginRequest.h"
#import "BLMultipartForm.h"
#import "YongUserModel.h"
#import "YongLoginParser.h"

@implementation GBMLoginRequest

-(void)sendLoginRequestWithEmail:(NSString *)email password:(NSString *)password gbid:(NSString *)gbid delegate:(id<GBMLoginRequestDelegate>)delegate{
    [self.urlConnection cancel];
    self.delegate = delegate;
    NSString *urlString  = @"http://moran.chinacloudapp.cn/moran/web/user/login";
    
    NSString *encondeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:encondeURLString]];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];;
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

#pragma mark - networking request delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *)response;
    if(httpresponse.statusCode == 200){
        self.receiveData = [NSMutableData data];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *string = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding ];
    NSLog(@"receive data string : %@",string);
    
    
    YongLoginParser *parser = [[YongLoginParser alloc]init];
    YongUserModel *user = [parser parseJson:self.receiveData];
    
    if ([_delegate respondsToSelector:@selector(loginRequestSuccess:user:)]) {
        [_delegate loginRequestSuccess:self user:user];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    self.receiveData = [NSMutableData data];
    [self.receiveData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
    if ([_delegate respondsToSelector:@selector(loginRequestFailed:error:)]) {
        [_delegate loginRequestFailed:self error:error];
    }
}

@end
