//
//  ZYGetImage.m
//  GBMoran_ios
//
//  Created by zhouyong on 15/11/25.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ZYGetImage.h"
#import "ZYGlobal.h"

@implementation ZYGetImage

- (void)sendGettingImageRequest {
    [self.urlconnection cancel];
    
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/show";
    urlString = [NSString stringWithFormat:@"%@?user_id=%@", urlString, [ZYGlobal shareGlobal].user.userId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    self.urlconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receiveData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [ZYGlobal shareGlobal].user.image = [[UIImage alloc] initWithData:self.receiveData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    
    //alert view
}
@end
