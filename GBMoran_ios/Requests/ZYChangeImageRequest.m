//
//  ZYChangeNickNameRequest.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/24.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYChangeImageRequest.h"
#import "BLMultipartForm.h"
#import "ZYGlobal.h"

@implementation ZYChangeImageRequest

- (void)sendChangingImageRequest:(UIImage *)image delegate:(id<ZYChangeImageRequestDelegate>)delegate{
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSURL *url = [NSURL URLWithString:@"http://moran.chinacloudapp.cn/moran/web/user/avatar"];
    NSData *data = UIImageJPEGRepresentation(image, 0.1);
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:[ZYGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[ZYGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:data forField:@"data"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
//    NSURLSession session = [NSURLSession sharedSession];
//    NSURLSessionDataTask task = [session dataTaskWithRequest:request];
    
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
    NSString *result = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
    if ([_delegate respondsToSelector:@selector(changeImageRequestSuccess:)]) {
        [_delegate changeImageRequestSuccess:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    if ([_delegate respondsToSelector:@selector(changeImageRequestFailed:error:)]) {
        [_delegate changeImageRequestFailed:self error:error];
    }
}

@end
