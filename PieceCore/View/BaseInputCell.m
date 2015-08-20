//
//  BaseInputView.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/23.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseInputCell.h"

@implementation BaseInputCell

- (void)initInputList {
    self.tfList = [NSMutableArray array];
    self.tvList = [NSMutableArray array];
    self.datePickerList = [NSMutableArray array];
    self.monthDayPickerList = [NSMutableArray array];
}
-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
}
-(void)setInputList {
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
}
@end
