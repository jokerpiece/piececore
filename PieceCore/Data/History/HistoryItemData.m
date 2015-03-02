//
//  HistoryItemModel.m
//  piece
//
//  Created by ハマモト  on 2014/10/24.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "HistoryItemData.h"

@implementation HistoryItemData
-(NSString *)getDeliverName{
    switch (self.deliverStatus) {
        case preparation:
            return @"出荷準備中";
            break;
        case sipment:
            return @"出荷済み";
            break;
        case deliver:
            return @"配送中";
            break;
        case delivered:
            return @"配達完了";
            break;
        default:
            return @"";
            break;
    }
}

-(NSString *)getDeliverMessage{
    switch (self.deliverStatus) {
        case preparation:
            return @"出荷の準備を行ってます。";
            break;
        case sipment:
            return @"荷物を出荷いたしました。";
            break;
        case deliver:
            return @"荷物は配達中です。";
            break;
        case delivered:
            return @"荷物は配達されました。";
            break;
        default:
            return @"";
            break;
    }
}

-(UIColor *)getColor{
    switch (self.deliverStatus) {
        case delivered:
            return [UIColor flatDarkBlueColor];
            break;
        case deliver:
            return [UIColor flatGreenColor];
            break;
        case sipment:
            return [UIColor blackColor];
            break;
        case preparation:
            return [UIColor grayColor];
            break;
            
        default:
            return [UIColor blackColor];
            break;
    }
}
@end
