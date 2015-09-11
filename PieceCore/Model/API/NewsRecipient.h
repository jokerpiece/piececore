//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import "BaseRecipient.h"

@interface NewsRecipient : BaseRecipient
@property (nonatomic,strong) NSString *news_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *image_url;
@property (nonatomic,strong) NSArray *link_list;
@property (nonatomic,strong) NSString *link_title;
@property (nonatomic,strong) NSString *link_url;
@end
