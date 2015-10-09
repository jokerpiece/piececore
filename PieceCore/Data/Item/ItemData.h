//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemData : NSObject
@property (nonatomic,strong) NSString *img_url;
@property (nonatomic,strong) NSString *category_id;
@property (nonatomic,strong) NSString *item_price;
@property (nonatomic,strong) NSString *item_url;
@property (nonatomic,strong) NSString *item_name;
@property (nonatomic,strong) NSString *item_text;
@property (nonatomic,strong) NSMutableDictionary *item_list;
@property (nonatomic,strong) NSString *shop_url;
@property (nonatomic,strong) NSString *item_id;
@property (nonatomic,strong) NSString *stock;

@end
