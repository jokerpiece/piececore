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
    self.answerList = [self.resultset objectForKey:@"answer_list"];
    self.answerNum = [self.resultset objectForKey:@"answer_list"];
    self.question = [self.resultset objectForKey:@"question"];
    self.lockCode = [self.resultset objectForKey:@"lockcode"];
}

@end
