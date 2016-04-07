//
//  linepay_ViewController.h
//  pieceSample
//
//  Created by ohnuma on 2015/07/10.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ItemListViewController.h"

#import "WebViewController.h"
#import "linepayReservSquareViewController.h"
#import "LinePayData.h"

@interface linepay_ViewController : BaseViewController<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *uv;
@property (nonatomic, strong) UIScrollView *sv;

//@property (strong, nonatomic) LinepayRecipient *linepeyrecipent;

@property (strong, nonatomic) NSString *itemImgUrl;
@property (strong, nonatomic) UIButton *line_button;
@property (strong, nonatomic) UIButton *button_1;
@property (strong, nonatomic) UIButton *button_2;
@property (strong, nonatomic) NSString *app_url;
@property (strong, nonatomic) NSString *string;
@property (strong, nonatomic) NSString *postage;
@property (strong, nonatomic) NSString *transaction;

@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSString *itemText;
@property (strong, nonatomic) NSString *itemPrice;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *itemStock;

@property (strong, nonatomic) UIButton *itemUp;
@property (strong, nonatomic) UIButton *itemDown;


@property (strong, nonatomic) UITextField *inputItemNumber;

@end
