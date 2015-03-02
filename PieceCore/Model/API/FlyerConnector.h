//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import "BaseConnector.h"
#import "FlyerHeaderData.h"
#import "FlyerBodyData.h"

@interface FlyerConnector : BaseConnector
@property (nonatomic,strong) NSMutableArray *headerList;
@property (nonatomic,strong) NSMutableArray *bodyList;
@end
