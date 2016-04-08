//
//  LinepaySelectAddressViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/10/01.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import "linepay_ViewController.h"

@interface LinepaySelectAddressViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *sameAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherAddressBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *mailLbl;
@property (weak, nonatomic) IBOutlet UILabel *telLbl;


@property (weak, nonatomic) NSString *item_name;
@property (weak, nonatomic) NSString *productId;
@property (weak, nonatomic) NSString *img_url;
@property (weak, nonatomic) NSString *itemImgUrl;
@property (weak, nonatomic) NSString *item_text;
@property (weak, nonatomic) NSString *item_price;

@end
