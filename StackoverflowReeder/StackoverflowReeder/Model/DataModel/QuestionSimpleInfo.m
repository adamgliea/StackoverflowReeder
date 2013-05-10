//
//  QuestionSimpleInfo.m
//  StackoverflowReeder
//
//  Created by Maozijun on 5/10/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import "QuestionSimpleInfo.h"

@interface QuestionSimpleInfo()

- (void)fillInfoWithInfo:(NSDictionary*)info;

@property (readwrite, strong, nonatomic) NSNumber *questionID;
@property (readwrite, strong, nonatomic) NSNumber *score;
@property (readwrite, strong, nonatomic) NSNumber *answerCount;
@property (readwrite, strong, nonatomic) NSNumber *viewCount;
@property (readwrite, strong, nonatomic) NSArray *tags;
@property (readwrite, strong, nonatomic) NSNumber *creationTime;
@property (readwrite, strong, nonatomic) NSString *title;

@end

@implementation QuestionSimpleInfo

#pragma mark --
#pragma mark - LifeCycle Functions
#pragma mark --

- (id)initWithInfo:(NSDictionary*)info {
    NSAssert(info != nil, @"question simple info eq nil");
    
    self = [super init];
    if (self != nil) {
        [self fillInfoWithInfo:info];
    }
    return self;
}

- (id)init {
    return [self initWithInfo:nil];
}

#pragma mark --
#pragma mark - Private Functions
#pragma mark --

- (void)fillInfoWithInfo:(NSDictionary*)info {
    self.questionID = info[@"question_id"];
    self.score = info[@"score"];
    self.answerCount = info[@"answer_count"];
    self.viewCount = info[@"view_count"];
    self.tags = info[@"tags"];
    self.creationTime = info[@"creation_date"];
    self.title = info[@"title"];
}

@end
