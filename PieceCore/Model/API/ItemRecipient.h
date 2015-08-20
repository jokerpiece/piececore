//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRecipient.h"
#import "ItemData.h"
#import "DLog.h"

@interface ItemRecipient : BaseRecipient
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,copy) NSString *quantity;
@property (nonatomic) bool more_flg;
@end
