//
//  RappingQuizeRecipient.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/16.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseRecipient.h"

@interface RappingQuizeRecipient : BaseRecipient
@property (nonatomic,strong) NSString *lockCode;
@property (nonatomic,strong) NSString *question;
@property (nonatomic)NSString *answerNum;
@property (nonatomic,strong) NSMutableArray *answerList;
@end
