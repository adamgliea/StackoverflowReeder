//
//  WebRequestProxy.h
//  StackoverflowReeder
//
//  Created by Maozijun on 4/9/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPClient;

@interface WebRequestProxy : NSObject

@property (readonly, nonatomic) AFHTTPClient *httpClint;

- (NSMutableURLRequest*)getRequestWithPath:(NSString*)path params:(NSDictionary*)params;

@end
