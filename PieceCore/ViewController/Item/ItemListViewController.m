//
//  ItemViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "ItemListViewController.h"

@interface ItemListViewController ()

@end

@implementation ItemListViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"ItemListViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic
{
    self.HeaderHeight = self.viewSize.width * 0.38;
    self.table = [[UITableView alloc] initWithFrame:[self.view bounds]];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    self.table.separatorColor = [UIColor whiteColor];
    self.title = @"商品一覧";
    //[self setSearchBar];
    [self setHeaderImg];
}
-(void)viewWillAppearLogic{
    self.data.list = [NSMutableArray array];
    if (self.searchType == category) {
        DLog(@"テーブル縦位置%f",self.table.frame.origin.y);
        self.table.frame = CGRectMake(0,NavigationHight + self.HeaderHeight,self.viewSize.width,self.viewSize.height - self.HeaderHeight -TabbarHight -NavigationHight);
        DLog(@"テーブル縦位置%f",self.table.frame.origin.y);
    }
    
}
- (void)viewDidAppearLogic {
    self.isResponse = NO;
    if (self.code.length > 0) {
        [self syncAction];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
        ItemData *model = [self.data.list objectAtIndex:indexPath.row];
        UIImageView *iv = [[UIImageView alloc] init];
        iv.frame = CGRectMake(10, 5, 80, 80);
        
        //SN画像URLをUTF8に変更
        NSURL *imageURL = [NSURL URLWithString:[model.img_url stringByAddingPercentEscapesUsingEncoding:
                                                NSUTF8StringEncoding]];
        
        [iv sd_setImageWithURL:imageURL
              placeholderImage:[UIImage imageNamed:@"wait.jpg"]
                       options:SDWebImageCacheMemoryOnly
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     }];
        [cell.contentView addSubview:iv];
        
        UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(100,20,self.viewSize.width - 110,40)];
        textLbl.text = model.item_name;
        textLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
        textLbl.alpha = 1.0f;
        textLbl.backgroundColor = [UIColor clearColor];
        textLbl.numberOfLines = 2;[cell.contentView addSubview:textLbl];
        
        UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width - 200,55,180,40)];
        priceLbl.text = [NSString stringWithFormat:@"%@円",model.item_price];
        priceLbl.font = [UIFont fontWithName:@"AppleGothic" size:13];
        priceLbl.alpha = 1.0f;
        priceLbl.textAlignment = NSTextAlignmentRight;
        priceLbl.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:priceLbl];
        //}
        return cell;
    } else {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor flatGrayColor];
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
        return 90.0f;
    } else {
        return 60.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.data.list.count;
    } else {
        if (self.isMore) {
            return 1;
        } else {
            return 0;
        }
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        ItemData *model = [self.data.list objectAtIndex:indexPath.row];
        ItemViewController *itemVc = [[ItemViewController alloc] initWithNibName:@"ItemViewController" bundle:nil];
        itemVc.url = model.item_url;
        // 画面をPUSHで遷移させる
        [self.navigationController pushViewController:itemVc animated:YES];
        
    } else if(indexPath.section == 1) {
        //self.selectPage ++;
        self.isSearchedMore = YES;
        [self syncAction];
        
    }
    
}

-(void)setHeaderImg{
    if (self.searchType != category) {
        return;
    }
    UIView *uv = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationHight, self.viewSize.width, self.HeaderHeight)];
    uv.backgroundColor = [UIColor grayColor];
    UIImageView *iv = [[UIImageView alloc] init];
    iv.frame = CGRectMake(0, 0, self.viewSize.width, self.viewSize.width * 0.28);
    NSURL *imageURL = [NSURL URLWithString:self.headerImgUrl];
    
    [iv sd_setImageWithURL:imageURL
          placeholderImage:[UIImage imageNamed:@"wait.jpg"]
                   options:SDWebImageCacheMemoryOnly
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     
                 }];
    [uv addSubview:iv];
    
    self.quanitityLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,uv.frame.size.height * 0.78,300,25)];
    
    self.quanitityLbl.text = [NSString stringWithFormat:@"アイテム数："];
    self.quanitityLbl.textColor = [UIColor whiteColor];
    self.quanitityLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    
    [uv addSubview:self.quanitityLbl];
    
    [self.view addSubview:uv];
    //self.table.tableHeaderView = uv;
}

-(void)setSearchBar{
    if (self.searchType != category) {
        return;
    }
    //検索バー
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44.0f)];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.placeholder = @"検索";
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
    
    [self syncAction];
}
-(void)searchBarCancelButtonClicked:(UISearchBar*)searchBar{
    [searchBar resignFirstResponder];
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSString *sendId;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    switch (self.searchType) {
        case coupon:
            sendId = SendIdItemCoupon;
            [param setValue:self.code forKey:@"coupon_id"];
            [param setValue:[NSNumber numberWithInt:(int)self.data.list.count] forKey:@"get_list_num"];
            break;
        case barcode:
            sendId = SendIdItemBarcode;
            [param setValue:self.code forKey:@"barcode_num"];
            [param setValue:[NSNumber numberWithInt:(int)self.data.list.count] forKey:@"get_list_num"];
            break;
            
        default:
            sendId = SendIdItem;
            [param setValue:self.code forKey:@"category_id"];
            [param setValue:self.searchBar.text forKey:@"sarch_word"];
            [param setValue:[NSNumber numberWithInt:(int)self.data.list.count] forKey:@"get_list_num"];
            break;
    }
    [conecter sendActionSendId:sendId param:param];
    
}

-(void)setData:(ItemConnector *)data sendId:(NSString *)sendId{
    
    if (self.isSearchedMore) {
        [self.data.list addObjectsFromArray: data.list];
    } else {
        self.data = data;
    }
    
    if (self.data.more_flg ) {
        self.isMore = YES;
    } else {
        self.isMore = NO;
    }
    self.isSearchedMore = NO;
    if (self.data.list.count == 1) {
        if (self.isNext) {
            self.isNext = NO;
            ItemData *model = [self.data.list objectAtIndex:0];
            ItemViewController *itemVc = [[ItemViewController alloc] initWithNibName:@"ItemViewController" bundle:nil];
            itemVc.url = model.item_url;
            // 画面をPUSHで遷移させる
            [self.navigationController pushViewController:itemVc animated:YES];
        } else {
            NSInteger count = self.navigationController.viewControllers.count - 2;
            CategoryViewController *vc = [self.navigationController.viewControllers objectAtIndex:count];
            [self.navigationController popToViewController:vc animated:YES];
        }
        
    }
    self.quanitityLbl.text = [NSString stringWithFormat:@"アイテム数：%@",self.data.quantity];
    [self.table reloadData];
}

-(BaseConnector *)getDataWithSendId:(NSString *)sendId{
    return [ItemConnector alloc];
}

@end
