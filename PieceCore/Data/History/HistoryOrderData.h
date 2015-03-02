//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HistoryItemData.h"

@interface HistoryOrderData : NSObject
@property (strong,nonatomic) NSString *strOrderNum;
@property (strong,nonatomic) NSString *strOrderDate;
@property (strong,nonatomic) NSString *strDeliverDate;

@property (nonatomic) int totalPrice;
@property (nonatomic) int feePrice;
@property (nonatomic) int discountPrice;
@property (nonatomic) int orderPrice;

@property (strong,nonatomic) NSMutableArray *historyItemList;
-(id)initSeedData;
@end
