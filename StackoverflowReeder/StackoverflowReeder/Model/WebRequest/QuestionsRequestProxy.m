//
//  QuestionsRequestProxy.m
//  StackoverflowReeder
//
//  Created by Maozijun on 4/28/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import "QuestionsRequestProxy.h"
#import "AFJSONRequestOperation.h"
#import "WebQuestionsDelegate.h"

@interface QuestionsRequestProxy()

+ (NSString*)stringOfSortType:(enum QuestionSortType)sortType;

@end

@implementation QuestionsRequestProxy

#pragma mark --
#pragma mark - Public Functions
#pragma mark --

- (NSString*)proxyPath {
    return @"questions";
}

- (void)questionsBySort:(enum QuestionSortType)sortType
          questionCount:(NSUInteger)questionCount
              pageIndex:(NSUInteger)pageIndex
              ascending:(BOOL)ascending {
    assert(pageIndex > 0);
    assert(questionCount > 0);
    
    NSDictionary *params = @{@"order" : ascending?@"asc":@"desc",
                             @"sort" : [QuestionsRequestProxy stringOfSortType:sortType],
                             @"pagesize" : [NSNumber numberWithUnsignedInteger:questionCount],
                             @"page" : [NSNumber numberWithUnsignedInteger:pageIndex],
                             };
    
    NSMutableURLRequest *request = [self getRequestWithParams:params];
    AFJSONRequestOperation *questionsOperation = [AFJSONRequestOperation
                                                  JSONRequestOperationWithRequest:request
                                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                      [self.delegate getQuestionsDidFinish:JSON error:nil];
                                                  }
                                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                      [self.delegate getQuestionsDidFinish:nil error:nil];
                                                  }];
    [questionsOperation start];
}

#pragma mark --
#pragma mark - Private Functions
#pragma mark --

+ (NSString*)stringOfSortType:(enum QuestionSortType)sortType {
    NSString *ret = nil;
    
    switch (sortType) {
        case QuestionSortType_Last_Activity_Date: {
            ret = @"activity";
        }break;
        case QuestionSortType_Creation_Date: {
            ret = @"creation";
        }break;
        case QuestionSortType_Hot: {
            ret = @"hot";
        }break;
        case QuestionSortType_Month: {
            ret = @"month";
        }break;
        case QuestionSortType_Votes: {
            ret = @"votes";
        }break;
        case QuestionSortType_Week: {
            ret = @"week";
        }break;
        default: {
            ret = @"activity";
        }break;
    }
    
    return ret;
}

@end
