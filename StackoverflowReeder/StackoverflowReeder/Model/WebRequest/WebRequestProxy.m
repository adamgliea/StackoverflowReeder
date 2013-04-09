//
//  WebRequestProxy.m
//  StackoverflowReeder
//
//  Created by Maozijun on 4/9/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import "WebRequestProxy.h"
#import "AFHTTPClient.h"

@interface WebRequestProxy()

@property (strong, nonatomic) AFHTTPClient *httpClint;

@end

@implementation WebRequestProxy

#pragma mark --
#pragma mark - Set/Get Functions
#pragma mark --

- (AFHTTPClient*)httpClint {
    static NSString *baseURLString = @"http://api.stackoverflow.com/1.1";
    
    if (_httpClint == nil) {
        NSURL *baseURL = [NSURL URLWithString:baseURLString];
        _httpClint = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    }
    
    return _httpClint;
}


@end
