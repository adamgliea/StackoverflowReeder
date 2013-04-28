//
//  WebRequestProxy.m
//  StackoverflowReeder
//
//  Created by Maozijun on 4/9/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#include <assert.h>

#import "WebRequestProxy.h"
#import "AFHTTPClient.h"

@interface WebRequestProxy()

@property (strong, nonatomic) AFHTTPClient *httpClint;

@end

@implementation WebRequestProxy

#pragma mark --
#pragma mark - Public Functions
#pragma mark --

- (NSString*)proxyPath {
    return nil;
}

- (NSMutableURLRequest*)getRequestWithParams:(NSDictionary*)params {
    NSString *requestPath = [self proxyPath];
    assert(requestPath != nil);
    
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:params];
    requestParams[@"site"] = @"stackoverflow";
    
    return [self.httpClint requestWithMethod:@"GET"
                                        path:requestPath
                                  parameters:requestParams];
}

#pragma mark --
#pragma mark - Set/Get Functions
#pragma mark --

- (AFHTTPClient*)httpClint {
    static NSString *baseURLString = @"https://api.stackexchange.com/2.1";
    
    if (_httpClint == nil) {
        NSURL *baseURL = [NSURL URLWithString:baseURLString];
        _httpClint = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    }
    
    return _httpClint;
}


@end
