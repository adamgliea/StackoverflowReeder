//
//  QuestionsRequestProxy.h
//  StackoverflowReeder
//
//  Created by Maozijun on 4/28/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import "WebRequestProxy.h"

enum QuestionSortType {
    QuestionSortType_Last_Activity_Date = 0,
    QuestionSortType_Creation_Date,
    QuestionSortType_Votes,
    QuestionSortType_Hot,
    QuestionSortType_Week,
    QuestionSortType_Month,
    
    QuestionSortType_Default = QuestionSortType_Last_Activity_Date,
};

@protocol WebQuestionsDelegate;

@interface QuestionsRequestProxy : WebRequestProxy

@property (assign, nonatomic) id<WebQuestionsDelegate> delegate;

- (void)questionsBySort:(enum QuestionSortType)sortType
          questionCount:(NSUInteger)questionCount
              pageIndex:(NSUInteger)pageIndex
              ascending:(BOOL)ascending;

@end
