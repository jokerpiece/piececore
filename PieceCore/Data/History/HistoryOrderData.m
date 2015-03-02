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
        self.strOrderNum = @"18038492-372888";
        self.strOrderDate = @"2014/09/15";
        self.strDeliverDate = @"2014/09/16";
        self.totalPrice = 33223;
        self.discountPrice = 200;
        self.feePrice = 600;
        self.historyItemList = [NSMutableArray array];
        
        HistoryItemData *historyItem1 = [HistoryItemData alloc];
        historyItem1.item_price = @"12744";
        historyItem1.item_text = @"GRASP ワルサー P38 ディスプレイ：ディスプレイ付き";
        historyItem1.item_url = @"http://otonagokoro.com/products/detail.php?product_id=26";
        historyItem1.img_url = @"http://otonagokoro.com/upload/save_image/05051921_4be146bfbce28.jpg";
        historyItem1.quantity = 1;
        historyItem1.deliverStatus = preparation;
        [self.historyItemList addObject:historyItem1];
        
        HistoryItemData *historyItem2 = [HistoryItemData alloc];
        historyItem2.item_price = @"10265";
        historyItem2.item_text = @"金沢箔で日本の情景を描いたUSBメモリー。";
        historyItem2.item_url = @"http://otonagokoro.com/products/detail.php?product_id=159";
        historyItem2.img_url = @"http://otonagokoro.com/upload/save_image/03142205_5141cafc0c357.jpg";
        historyItem2.quantity = 1;
        historyItem2.deliverStatus = sipment;
        [self.historyItemList addObject:historyItem2];
        
        HistoryItemData *historyItem3 = [HistoryItemData alloc];
        historyItem3.item_price = @"3024";
        historyItem3.item_text = @"酒器セット(白磁の酒器・ぐい呑みのセット)";
        historyItem3.item_url = @"http://otonagokoro.com/products/detail.php?product_id=10";
        historyItem3.img_url = @"http://otonagokoro.com/upload/save_image/05022134_4bdd7158147de.jpg";
        historyItem3.quantity = 1;
        historyItem3.deliverStatus = deliver;
        [self.historyItemList addObject:historyItem3];
        
        HistoryItemData *historyItem4 = [HistoryItemData alloc];
        historyItem4.item_price = @"3024";
        historyItem4.item_text = @"ADOLE MACKBOOK AIR CASE 13";
        historyItem4.item_url = @"http://otonagokoro.com/products/detail.php?product_id=939";
        historyItem4.img_url = @"http://otonagokoro.com/upload/save_image/08122223_53ea156ee2e08.jpg";
        historyItem4.quantity = 1;
        historyItem4.deliverStatus = delivered;
        [self.historyItemList addObject:historyItem4];
    }
    
    return self;
}
@end
