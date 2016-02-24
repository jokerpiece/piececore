//
//  WebViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemRecipient.h"
#import "WebViewController.h"
#import "CategoryViewController.h"
#import "BaseViewController.h"
#import "linepay_ViewController.h"
#import "linepayReservSquareViewController.h"
#import "PaypalViewController.h"
#import "DLog.h"

typedef enum {
    category = 0,
    barcode,
    coupon,
    serchWord,
} itemSearchType;

@interface ItemListViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate>
@property (strong, nonatomic) ItemRecipient *itemRecipient;
@property (nonatomic) bool isMore;
@property (nonatomic) bool isNext;
@property (nonatomic) bool isSearchedMore;
@property (nonatomic) UITableView *table;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (nonatomic) itemSearchType searchType;
@property (nonatomic) NSString *searchWord;
@property (strong, nonatomic) NSString *headerImgUrl;
@property (strong, nonatomic) UILabel *quanitityLbl;
@property (strong, nonatomic) UILabel *stockLbl;
@property (nonatomic) float sarchCellHeight;
@property (nonatomic) float HeaderHeight;

@property (nonatomic) NSString *item_name;
@property (nonatomic) UIImageView *item_image;
@property (nonatomic) NSString *item_text;
@property (nonatomic) NSString *item_price;
@property (nonatomic) bool isCloseWebview;
-(void)setCartBtn;

@end

