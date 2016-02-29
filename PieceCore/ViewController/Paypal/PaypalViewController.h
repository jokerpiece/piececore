//
//  PaypalViewController.h
//  pieceSample
//
//  Created by uwatoko on 2016/01/06.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PayPalMobile.h"

@interface PaypalViewController : BaseViewController<UIScrollViewDelegate, PayPalPaymentDelegate>

@property (nonatomic, strong) UIView *uv;

@property (strong, nonatomic) UIButton *paypal_button;
@property (nonatomic, strong) UIScrollView *sv;

@property (strong, nonatomic) NSString *item_name;
@property (strong, nonatomic) NSString *img_url;
@property (strong, nonatomic) NSString *item_text;
@property (strong, nonatomic) NSString *item_price;
@property (strong, nonatomic) NSString *item_id;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;

@end
