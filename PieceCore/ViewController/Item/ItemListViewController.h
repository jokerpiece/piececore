//
//  ItemViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemConnector.h"
#import "ItemViewController.h"
#import "CategoryViewController.h"
#import "BaseViewController.h"
typedef enum {
    category = 0,
    barcode,
    coupon,
} itemSearchType;

@interface ItemListViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate>
@property (strong, nonatomic) ItemConnector *data;
@property (nonatomic) bool isMore;
@property (nonatomic) bool isNext;
@property (nonatomic) bool isSearchedMore;
@property (nonatomic) UITableView *table;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (nonatomic) itemSearchType searchType;
@property (strong, nonatomic) NSString *headerImgUrl;
@property (strong, nonatomic) UILabel *quanitityLbl;
@property (nonatomic) float sarchCellHeight;
@property (nonatomic) float HeaderHeight;
@end
