//
//  StackoverflowReederTests.m
//  StackoverflowReederTests
//
//  Created by Maozijun on 4/9/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import "StackoverflowReederTests.h"
#import "QuestionsRequestProxy.h"

@interface StackoverflowReederTests()

@property (assign, nonatomic) BOOL isWaiting;

- (void)waitNetworkResponse;

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

- (void)testGetQuestions {
    QuestionsRequestProxy *proxy = [[QuestionsRequestProxy alloc] init];
    proxy.delegate = self;
    
    self.isWaiting = YES;
    [proxy questionsBySort:QuestionSortType_Last_Activity_Date
             questionCount:20
                 pageIndex:1
                 ascending:NO];
    
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

#pragma mark --
#pragma mark - WebQuestionsDelegate
#pragma mark --

- (void)getQuestionsDidFinish:(NSDictionary*)result
                        error:(NSError*)error {
    self.isWaiting = NO;
    
    STAssertNil(error, @"Questions request fail");
}

@end
