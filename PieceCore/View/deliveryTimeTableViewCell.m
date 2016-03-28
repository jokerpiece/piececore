//
//  deliveryTimeTableViewCell.m
//  pieceSample
//
//  Created by shinden nobuyuki on 2016/03/25.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "deliveryTimeTableViewCell.h"

@implementation deliveryTimeTableViewCell

NSArray *timeList;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(closeKeyboard)];
    [self.viewForBaselineLayout addGestureRecognizer:gestureRecognizer];
}

-(void)closeKeyboard{
    //キーボード以外を押された時の処理
    [self.superview.superview.superview endEditing:YES];
}

-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
    if ([Common isNotEmptyString:recipient.delivery_time]) {
        if([recipient.delivery_time isEqualToString:@"指定なし"]){
            self.noTimeBtn.selected = YES;
        }else if([recipient.delivery_time isEqualToString:@"午前中"]){
            self.amBtn.selected = YES;
        }else if([recipient.delivery_time isEqualToString:@"12:00~14:00"]){
            self.twelveBtn.selected = YES;
        }else if([recipient.delivery_time isEqualToString:@"14:00~16:00"]){
            self.fourteenBtn.selected = YES;
        }else if([recipient.delivery_time isEqualToString:@"16:00~18:00"]){
            self.sixteenBtn.selected = YES;
        }else if([recipient.delivery_time isEqualToString:@"18:00~20:00"]){
            self.eighteenBtn.selected = YES;
        }else if([recipient.delivery_time isEqualToString:@"20:00~21:00"]){
            self.twentyBtn.selected = YES;
        }
    }
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
    NSString *str;
    if(self.noTimeBtn.selected){
        str = @"指定なし";
    }else if(self.amBtn.selected){
        str = @"午前中";
    }else if(self.twelveBtn.selected){
        str = @"12:00~14:00";
    }else if(self.fourteenBtn.selected){
        str = @"14:00~16:00";
    }else if(self.sixteenBtn.selected){
        str = @"16:00~18:00";
    }else if(self.eighteenBtn.selected){
        str = @"18:00~20:00";
    }else if(self.twentyBtn.selected){
        str = @"20:00~21:00";
    }
    recipient.delivery_time = str;
}

- (IBAction)selectAction:(UIButton*)sender {
    self.noTimeBtn.selected = NO;
    self.amBtn.selected = NO;
    self.twelveBtn.selected = NO;
    self.fourteenBtn.selected = NO;
    self.sixteenBtn.selected = NO;
    self.eighteenBtn.selected = NO;
    self.twentyBtn.selected = NO;
    sender.selected = YES;
}

@end
