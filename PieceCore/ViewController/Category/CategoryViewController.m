//
//  CategoryViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CategoryViewController.h"
#import "RoundView.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"CategoryViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic
{
    [self setCartBtn];
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].categoryTitle;
    }
    if (self.pageCode.length < 1) {
        self.pageCode = [PieceCoreConfig pageCodeData].categoryTitle;
    }
    [self setSearchBar];
    self.categoryRecipient.list = [NSMutableArray array];
    self.table.delegate = self;
    self.cellHeight = self.viewSize.width * 0.28;
}

- (void)viewWillAppearLogic
{
    [self setCartBtn];
    self.isResponse = NO;
    [self syncAction];
}

-(void)setCartBtn{
    
    if ([Common isNotEmptyString:[PieceCoreConfig cartUrl]]) {
        //LinaPay決済機能ステータス
        NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
        NSInteger flagLinePay = [userData integerForKey:@"LINEPAY"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
        [button sizeToFit];
        [button addTarget:self action:@selector(cartTapp:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

        if(flagLinePay == 1){
            button.hidden = YES;
        }else if(flagLinePay == 0){
            button.hidden = NO;
        }
    }
    
}

-(void)setSearchBar{
    if (![PieceCoreConfig isDispSearchBar]) {
        return;
    }
    
    //検索バー
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 15, self.view.bounds.size.width, 52.0f)];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.placeholder = @"何かお探しですか？";
    //デフォルトキーボードタイプ
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.searchBar.barStyle = UIBarStyleDefault;
    
    //テーブルビューのヘッダーに設定
    self.table.tableHeaderView = self.searchBar;
}


- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar

{
    [searchBar resignFirstResponder];
    self.isResponse = NO;
    ItemListViewController *itemListVc = [[ItemListViewController alloc] initWithNibName:@"ItemListViewController" bundle:nil];
    itemListVc.searchType = serchWord;
    itemListVc.searchWord = self.searchBar.text;
    
    [self.navigationController pushViewController:itemListVc animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void)cartTapp:(UITapGestureRecognizer *)sender
{
    
    if ([Common isNotEmptyString:[PieceCoreConfig cartUrl]]) {
        
        WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:[PieceCoreConfig cartUrl]];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        CategoryData *data = [self.categoryRecipient.list objectAtIndex:indexPath.row];
        if ([Common isNotEmptyString:data.img_url]) {
            UIImageView *iv = [[UIImageView alloc] init];
            iv.frame = CGRectMake(0, 0, self.viewSize.width, self.cellHeight);
            NSURL *imageURL = [NSURL URLWithString:data.img_url];
            
            [iv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [cell.contentView addSubview:iv];
        } else {
            RoundView *view = [[RoundView alloc]initWithFrame:CGRectMake(10, 10, self.viewSize.width - 20, self.cellHeight-20)];
            view.backgroundColor = [UIColor lightGrayColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, view.frame.size.width - 20, view.frame.size.height -20)];
            label.text = data.category_name;
            label.numberOfLines = 3;
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont boldSystemFontOfSize:23.0f];
            label.shadowColor = [UIColor blackColor];
            label.shadowOffset = CGSizeMake(0, 1);
            [view addSubview:label];
            [cell.contentView addSubview:view];
        }
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
            UIImageView *reloadView = [[UIImageView alloc] init];
            reloadView.frame = CGRectMake(80,15, 32, 32);
            reloadView.image = [UIImage imageNamed:@"undo.png"];
            [cell.contentView addSubview:reloadView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125,20,100,25)];
            label.text = @"次を検索する";
            label.font = [UIFont fontWithName:@"AppleGothic" size:16];
            label.alpha = 1.0f;
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
        }
        return cell;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.cellHeight;
    } else {
        return 60.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.categoryRecipient.list.count;
    } else {
        if (self.isMore) {
            return 1;
        } else {
            return 0;
        }
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isStaticPage) {
        return;
    }
    self.selectCategory = [self.categoryRecipient.list objectAtIndex:indexPath.row];
    ItemListViewController *itemListVc = [[ItemListViewController alloc] initWithNibName:@"ItemListViewController" bundle:nil];
    itemListVc.isNext = YES;
    itemListVc.searchType = category;
    itemListVc.code = self.selectCategory.category_id;
    itemListVc.headerImgUrl = self.selectCategory.img_url;
    
    [self.navigationController pushViewController:itemListVc animated:YES];
    return;
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [conecter sendActionSendId:SendIdCategory param:param];
    
}

-(void)setDataWithRecipient:(CategoryRecipient *)recipient sendId:(NSString *)sendId{
    self.categoryRecipient = recipient;
    [self.table reloadData];
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [CategoryRecipient alloc];
}


@end
