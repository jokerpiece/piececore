//
//  ItemDetailData.h
//  pieceSample
//
//  Created by OhnumaRina on 2016/05/17.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailData : NSObject

@property (nonatomic,strong) NSDictionary *list;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *item_code;
@property (nonatomic, strong) NSArray *kikaku_name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *quantity;


@end
