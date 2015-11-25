//
//  ZYChangeNickNameRequest.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYChangeNickNameRequest.h"
#import "BLMultipartForm.h"
#import "ZYGlobal.h"

@implementation ZYChangeNickNameRequest

- (void)sendChangingNickNameRequest:(NSString *)nickName delegate:(id<ZYChangeNickNameRequestDelegate>)delegate{
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSURL *url = [NSURL URLWithString:@"http://moran.chinacloudapp.cn/moran/web/user/rename"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:[ZYGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[ZYGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:nickName forField:@"new_name"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *string = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"rename data string %@", string);
    if ([_delegate respondsToSelector:@selector(changeNickNameRequestSuccess:)]) {
        [_delegate changeNickNameRequestSuccess:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    if ([_delegate respondsToSelector:@selector(changeNickNameRequestFailed:error:)]) {
        [_delegate changeNickNameRequestFailed:self error:error];
    }
}

@end
