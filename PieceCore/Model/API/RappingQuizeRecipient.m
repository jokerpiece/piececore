//
//  RappingQuizeRecipient.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/16.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingQuizeRecipient.h"

@implementation RappingQuizeRecipient

-(void)setData{
    //リスト
    self.questionId = [self.resultset objectForKey:@"question_id"];
    self.questionText = [self.resultset objectForKey:@"question_text"];
    self.questionNum = [self.resultset objectForKey:@"question_num"];
    self.answer1 = [self.resultset objectForKey:@"answer_1"];
    self.answer2 = [self.resultset objectForKey:@"answer_2"];
    self.answer3 = [self.resultset objectForKey:@"answer_3"];
    self.answer4 = [self.resultset objectForKey:@"answer_4"];
    self.correct = [self.resultset objectForKey:@"correct"];
    self.pinCode = [self.resultset objectForKey:@"pin_code"];
}
@end
