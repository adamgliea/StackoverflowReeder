//
//  StackoverflowReederTests.m
//  StackoverflowReederTests
//
//  Created by Maozijun on 4/9/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import "StackoverflowReederTests.h"
#import "QuestionsRequestProxy.h"
#import "QuestionSimpleInfo.h"

@interface StackoverflowReederTests()

@property (assign, nonatomic) BOOL isWaiting;

- (void)waitNetworkResponse;
- (void)getQuestionsWithSortType:(enum QuestionSortType)sortType;

@end

@implementation StackoverflowReederTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.isWaiting = NO;
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testGetQuestionsWithLastActivityDate {
    [self getQuestionsWithSortType:QuestionSortType_Last_Activity_Date];
}

- (void)testGetQuestionsWithCreationDate {
    [self getQuestionsWithSortType:QuestionSortType_Creation_Date];
}

- (void)testGetQuestionsWithVotes {
    [self getQuestionsWithSortType:QuestionSortType_Votes];
}

- (void)testGetQuestionsWithHot {
    [self getQuestionsWithSortType:QuestionSortType_Hot];
}

- (void)testGetQuestionsWithWeek {
    [self getQuestionsWithSortType:QuestionSortType_Week];
}

- (void)testGetQuestionsWithMonth {
    [self getQuestionsWithSortType:QuestionSortType_Month];
}

- (void)testGetQuestionsWithDefault {
    [self getQuestionsWithSortType:QuestionSortType_Default];
}

- (void)testGetQuestion {
    static NSString *testQuestionID = @"16457296";
    
    QuestionsRequestProxy *proxy = [[QuestionsRequestProxy alloc] init];
    proxy.delegate = self;
    
    self.isWaiting = YES;
    [proxy questionWithQuestionID:testQuestionID];
    
    [self waitNetworkResponse];
}

- (void)testGetQuestionAnswers {
    static NSString *testQuestionID = @"16457296";
    
    QuestionsRequestProxy *proxy = [[QuestionsRequestProxy alloc] init];
    proxy.delegate = self;
    
    self.isWaiting = YES;
    [proxy questionAnswersWithQuestionID:testQuestionID];
    
    [self waitNetworkResponse];
}

#pragma mark --
#pragma mark - Private Functions
#pragma mark --

- (void)waitNetworkResponse {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:60];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
    } while (self.isWaiting);
}

- (void)getQuestionsWithSortType:(enum QuestionSortType)sortType {
    QuestionsRequestProxy *proxy = [[QuestionsRequestProxy alloc] init];
    proxy.delegate = self;
    
    self.isWaiting = YES;
    [proxy questionsBySort:sortType
             questionCount:20
                 pageIndex:1
                 ascending:NO];
    
    [self waitNetworkResponse];
}

#pragma mark --
#pragma mark - WebQuestionsDelegate
#pragma mark --

- (void)getQuestionsDidFinish:(NSDictionary*)result
                        error:(NSError*)error {
    self.isWaiting = NO;
    
    STAssertNil(error, @"Questions request fail");
    
    NSArray *questions = result[@"items"];
//    STAssertNotNil(questions, @"Questions is nil");
    
    [questions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *questionInfo = obj;
        
        QuestionSimpleInfo *simpleInfo = [[QuestionSimpleInfo alloc] initWithInfo:questionInfo];
    }];
}

- (void)getQuestionDidFinish:(NSDictionary*)result
                       error:(NSError*)error {
    self.isWaiting = NO;
    
    STAssertNil(error, @"Question request fail");
}

- (void)getQuestionAnswersDidFinish:(NSDictionary*)result
                              error:(NSError*)error {
    self.isWaiting = NO;
    
    STAssertNil(error, @"Question answers request fail");
}

@end
