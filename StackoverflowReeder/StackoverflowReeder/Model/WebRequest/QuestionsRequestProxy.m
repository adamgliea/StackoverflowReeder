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
    
    NSMutableURLRequest *request = [self getRequestWithPath:@"questions" params:params];
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

- (void)questionWithQuestionID:(NSString*)questionID {
    assert(questionID != nil);
    
    NSDictionary *params = @{@"filter" : @"withbody",};
    
    NSString *requestPath = [NSString stringWithFormat:@"questions/%@", questionID, nil];
    NSMutableURLRequest *request = [self getRequestWithPath:requestPath params:params];
    AFJSONRequestOperation *questionsOperation = [AFJSONRequestOperation
                                                  JSONRequestOperationWithRequest:request
                                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                      [self.delegate getQuestionDidFinish:JSON error:nil];
                                                  }
                                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                      [self.delegate getQuestionDidFinish:nil error:nil];
                                                  }];
    [questionsOperation start];
}

- (void)questionAnswersWithQuestionID:(NSString*)questionID {
    assert(questionID != nil);
    
    NSDictionary *params = @{@"filter" : @"withbody",};
    
    NSString *requestPath = [NSString stringWithFormat:@"questions/%@/answers", questionID, nil];
    NSMutableURLRequest *request = [self getRequestWithPath:requestPath params:params];
    AFJSONRequestOperation *questionsOperation = [AFJSONRequestOperation
                                                  JSONRequestOperationWithRequest:request
                                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                      [self.delegate getQuestionAnswersDidFinish:JSON error:nil];
                                                  }
                                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                      [self.delegate getQuestionAnswersDidFinish:nil error:nil];
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
