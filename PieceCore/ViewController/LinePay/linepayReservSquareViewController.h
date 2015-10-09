//
//  linepayReservSquareViewController.h
//  pieceSample
//
//  Created by ohnuma on 2015/07/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ItemListViewController.h"
#import "ProfileViewController.h"
#import "WebViewController.h"
#import "ProfileRecipient.h"
#import "linepay_ViewController.h"
#import "LinepayRecipient.h"
#import "LinePayData.h"
#import "DeterminedLinePayRecipient.h"
#import "linepay_ViewController.h"


@interface linepayReservSquareViewController : BaseViewController<UIScrollViewDelegate>

@property (nonatomic, strong) ProfileRecipient *profilerecipient;
@property (nonatomic, strong) LinepayRecipient *linepayrecipient;
//@property (nonatomic, strong) BaseRecipient *recipient;

@property (nonatomic, strong) UIView *uv;
@property (nonatomic, strong) UIScrollView *sv;
@property (weak, nonatomic) IBOutlet UILabel *item_name;
@property (weak, nonatomic) IBOutlet UILabel *item_price;
@property (weak, nonatomic) IBOutlet UILabel *postage;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *mail_address;
@property (weak, nonatomic) IBOutlet UILabel *address;


- (IBAction)reserv:(id)sender;
- (IBAction)cancel:(id)sender;

@end
