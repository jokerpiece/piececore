//
//  BaseInputView.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/23.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileRecipient.h"
#import "Common.h"

@interface BaseInputCell : UITableViewCell
@property NSMutableArray *tfList;
@property NSMutableArray *tvList;
@property NSMutableArray *datePickerList;
@property NSMutableArray *monthDayPickerList;
- (void)initInputList;
-(void)setInputList;
-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient;
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient;
@end
