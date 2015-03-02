//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import "BaseConnector.h"

@interface NewsConnector : BaseConnector
@property (nonatomic,strong) NSString *news_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *text;
@end
