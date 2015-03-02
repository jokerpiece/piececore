//
//  CategoryViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CategoryConnector.h"
#import "CategoryData.h"
#import "ItemListViewController.h"
#import "BaseViewController.h"

@interface CategoryViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) CategoryConnector *data;
@property (nonatomic) bool isMore;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) CategoryData *selectCategory;
@property (nonatomic) float cellHeight;
@end
