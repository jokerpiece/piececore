//
//  GetSurveyData.m
//  piece
//
//  Created by ハマモト  on 2014/10/02.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SurveyConnector.h"

@implementation SurveyConnector
-(void)setData{
    self.survey_id = [self.resultset valueForKey:@"survey_id"];
    self.text = [self.resultset valueForKey:@"text"];
    self.answer_1 = [self.resultset valueForKey:@"answer_1"];
    self.answer_2 = [self.resultset valueForKey:@"answer_2"];
    self.answer_3 = [self.resultset valueForKey:@"answer_3"];
}
@end
