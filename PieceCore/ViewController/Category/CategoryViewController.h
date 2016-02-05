//
//  CategoryViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CategoryRecipient.h"
#import "CategoryData.h"
#import "ItemListViewController.h"
#import "BaseViewController.h"

@interface CategoryViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) CategoryRecipient *categoryRecipient;
@property (nonatomic) bool isMore;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) CategoryData *selectCategory;
@property (nonatomic) float cellHeight;
@property (nonatomic) bool isStaticPage;
@property (strong, nonatomic) UISearchBar *searchBar;

-(void)setCartBtn;
@end
