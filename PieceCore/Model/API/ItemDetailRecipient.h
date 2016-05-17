//
//  ItemDetailRecipient.h
//  pieceSample
//
//  Created by OhnumaRina on 2016/05/17.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseRecipient.h"
#import "itemDetailData.h"


@interface ItemDetailRecipient :BaseRecipient

@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic, strong) NSString *quantity;

@end
