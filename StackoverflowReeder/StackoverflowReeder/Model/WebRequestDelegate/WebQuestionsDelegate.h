//
//  WebQuestionsDelegate.h
//  StackoverflowReeder
//
//  Created by Maozijun on 4/28/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebQuestionsDelegate <NSObject>

- (void)getQuestionsDidFinish:(NSDictionary*)result
                        error:(NSError*)error;

- (void)getQuestionDidFinish:(NSDictionary*)result
                       error:(NSError*)error;

- (void)getQuestionAnswersDidFinish:(NSDictionary*)result
                              error:(NSError*)error;

@end
