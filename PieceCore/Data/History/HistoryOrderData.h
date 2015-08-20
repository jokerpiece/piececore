//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HistoryItemData.h"

@interface HistoryOrderData : NSObject
/**
 注文番号
 */
@property (strong,nonatomic) NSString *orderNum;
/**
 注文日
 */
@property (strong,nonatomic) NSString *orderDate;
/**
 合計金額
 */
@property (nonatomic) NSString *totalPrice;
/**
 商品明細
 */
@property (strong,nonatomic) NSMutableArray *historyItemList;
-(id)initSeedData;

@end
