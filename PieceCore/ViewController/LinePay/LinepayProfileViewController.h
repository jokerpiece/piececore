//
//  LinepayProfileViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/10/02.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "ProfileViewController.h"

@interface LinepayProfileViewController : ProfileViewController
@property (nonatomic) NSString* linePayUrl;
@property (strong, nonatomic) NSString *item_name;
@property (strong, nonatomic) NSString *img_url;
@property (strong, nonatomic) NSString *item_text;
@property (strong, nonatomic) NSString *item_price;
@end
