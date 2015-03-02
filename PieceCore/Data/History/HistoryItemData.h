//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemData.h"
#import "UIColor+MLPFlatColors.h"
typedef enum {
    preparation = 0,
    sipment,
    deliver,
    delivered
} deliverStatus;

@interface HistoryItemData : ItemData
@property (strong,nonatomic) NSString *strOrderNum;
@property (nonatomic) deliverStatus deliverStatus;
@property (nonatomic) int quantity;
-(NSString *)getDeliverName;
-(NSString *)getDeliverMessage;
-(UIColor *)getColor;
@end
