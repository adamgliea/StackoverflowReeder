//
//  QuestionSimpleInfo.h
//  StackoverflowReeder
//
//  Created by Maozijun on 5/10/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionSimpleInfo : NSObject

- (id)initWithInfo:(NSDictionary*)info;

@property (readonly, strong, nonatomic) NSNumber *questionID;
@property (readonly, strong, nonatomic) NSNumber *score;
@property (readonly, strong, nonatomic) NSNumber *answerCount;
@property (readonly, strong, nonatomic) NSNumber *viewCount;
@property (readonly, strong, nonatomic) NSArray *tags;
@property (readonly, strong, nonatomic) NSNumber *creationTime;
@property (readonly, strong, nonatomic) NSString *title;

@end
