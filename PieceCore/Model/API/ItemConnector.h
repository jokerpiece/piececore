//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseConnector.h"
#import "ItemData.h"
#import "DLog.h"

@interface ItemConnector : BaseConnector
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,copy) NSString *quantity;
@property (nonatomic) bool more_flg;
@end
