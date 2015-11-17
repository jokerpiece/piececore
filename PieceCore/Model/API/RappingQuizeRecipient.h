//
//  RappingQuizeRecipient.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/16.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseRecipient.h"

@interface RappingQuizeRecipient : BaseRecipient
@property (nonatomic,strong) NSString *questionId;
@property (nonatomic,strong) NSString *questionText;
@property (nonatomic) NSString *questionNum;
@property (nonatomic) NSDictionary *answer1;
@property (nonatomic) NSDictionary *answer2;
@property (nonatomic) NSDictionary *answer3;
@property (nonatomic) NSDictionary *answer4;
@property (nonatomic) NSString *correct;
@property (nonatomic) NSString *pinCode;
@end
