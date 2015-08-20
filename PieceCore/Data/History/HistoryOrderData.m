//
//  HistoryOrderModel.m
//  piece
//
//  Created by ハマモト  on 2014/10/24.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "HistoryOrderData.h"

@implementation HistoryOrderData
-(id)initSeedData {
    if (self = [super init]) {
        self.orderNum = @"18038492-372888";
        self.orderDate = @"2014/09/15";
        self.totalPrice = @"33223";
        self.historyItemList = [NSMutableArray array];
        
        HistoryItemData *historyItem1 = [HistoryItemData alloc];
        historyItem1.item_price = @"12744";
        historyItem1.item_name = @"GRASP ワルサー P38 ディスプレイ：ディスプレイ付き";
        historyItem1.quantity = @"1";
        historyItem1.img_url = @"http://otonagokoro.com/upload/save_image/05051921_4be146bfab8ce.jpg";
        historyItem1.deliverCampany = yamato;
        historyItem1.deliverNum = @"410614362502";
        [self.historyItemList addObject:historyItem1];
        
        HistoryItemData *historyItem2 = [HistoryItemData alloc];
        historyItem2.item_price = @"10265";
        historyItem2.item_name = @"金沢箔で日本の情景を描いたUSBメモリー。";
        historyItem2.quantity = @"1";
        historyItem2.img_url = @"http://otonagokoro.com/upload/save_image/03142141_5141c585a96bc.jpg";
        historyItem2.deliverCampany = sagawa;
        historyItem2.deliverNum = @"401997807396";
        [self.historyItemList addObject:historyItem2];
        
        HistoryItemData *historyItem3 = [HistoryItemData alloc];
        historyItem3.item_price = @"3024";
        historyItem3.item_name = @"酒器セット(白磁の酒器・ぐい呑みのセット)";
        historyItem3.quantity = @"1";
        historyItem3.img_url = @"http://otonagokoro.com/upload/save_image/05022134_4bdd715803305.jpg";
        historyItem3.deliverCampany = sagawa;
        historyItem3.deliverNum = @"401997807396";
        [self.historyItemList addObject:historyItem3];
        
        HistoryItemData *historyItem4 = [HistoryItemData alloc];
        historyItem4.item_price = @"3024";
        historyItem4.item_name = @"ADOLE MACKBOOK AIR CASE 13";
        historyItem4.quantity = @"1";
        historyItem4.img_url = @"http://otonagokoro.com/upload/save_image/08122224_53ea157961db3.jpg";
        historyItem4.deliverCampany = sagawa;
        historyItem4.deliverNum = @"401997807396";
        [self.historyItemList addObject:historyItem4];
    }
    
    return self;
}
@end
