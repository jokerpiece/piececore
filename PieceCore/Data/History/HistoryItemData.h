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

typedef enum {
    yamato = 0,
    sagawa,
    yubin
} deliverCampany;


@interface HistoryItemData : NSObject

/**
 伝票番号
 */
@property (nonatomic) NSString *deliverNum;
/**
 配送業者
 */
@property (nonatomic) deliverCampany deliverCampany;
/**
 商品名
 */
@property (nonatomic) NSString *item_name;
/**
 数量
 */
@property (nonatomic) NSString *quantity;
/**
 価格
 */
@property (nonatomic) NSString *item_price;
/**
 小計
 */
@property (nonatomic) NSString* sub_total_price;
/**
 商品URL
 */
@property (nonatomic,strong) NSString *img_url;

//-(NSString *)getDeliverName;
//-(NSString *)getDeliverMessage;
//-(UIColor *)getColor;
@end