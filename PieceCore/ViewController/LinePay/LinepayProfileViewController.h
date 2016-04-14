//
//  LinepayProfileViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/10/02.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "ProfileViewController.h"
#import "linepayReservSquareViewController.h"

@interface LinepayProfileViewController : ProfileViewController<ViewItemListDelegate>
@property (nonatomic) NSString* linePayUrl;
@property (nonatomic) BOOL isSameProfileFlg;
@end
