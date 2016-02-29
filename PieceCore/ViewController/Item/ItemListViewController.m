//
//  WebViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "ItemListViewController.h"

@interface ItemListViewController ()

@property UIImage *image;

@end

@implementation ItemListViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"ItemListViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic
{
    self.isCloseWebview = NO;
    [self setCartBtn];
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].itemListTitle;
    }
    self.HeaderHeight = self.viewSize.width * 0.38;
    self.table = [[UITableView alloc] initWithFrame:[self.view bounds]];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    self.table.separatorColor = [UIColor whiteColor];
    //[self setSearchBar];
    [self setHeaderImg];
}


-(void)setCartBtn{
    
    if ([Common isNotEmptyString:[PieceCoreConfig cartUrl]]) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
        [button sizeToFit];
        [button addTarget:self action:@selector(cartTapp:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
}

- (void)cartTapp:(UITapGestureRecognizer *)sender
{
    
    if ([Common isNotEmptyString:[PieceCoreConfig cartUrl]]) {
        
        WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:[PieceCoreConfig cartUrl]];
        [self presentViewController:vc animated:YES completion:nil];
        self.isCloseWebview = YES;
    }
    
}

-(void)viewWillAppearLogic{

    if (self.searchType == category) {
        DLog(@"テーブル縦位置%f",self.table.frame.origin.y);
        self.table.frame = CGRectMake(0,NavigationHight + self.HeaderHeight,self.viewSize.width,self.viewSize.height - self.HeaderHeight -TabbarHight -NavigationHight);
        DLog(@"テーブル縦位置%f",self.table.frame.origin.y);
    } else {
        self.table.frame = CGRectMake(0,NavigationHight,self.viewSize.width,self.viewSize.height -TabbarHight -NavigationHight);
    }
    
}
- (void)viewDidAppearLogic {
    self.isResponse = NO;
    if (self.code.length > 0 || self.searchWord.length > 0) {
        if (!self.isCloseWebview) {
            self.itemRecipient.list = [NSMutableArray array];
            [self.table reloadData];
            [self syncAction];

        }
        self.isCloseWebview = NO;
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
        
        if (self.itemRecipient.list.count == 0) {
            return cell;
        }
        
        ItemData *data = [self.itemRecipient.list objectAtIndex:indexPath.row];
        UIImageView *iv = [[UIImageView alloc] init];
        iv.frame = CGRectMake(10, 5, 80, 80);
        
        if ([Common isNotEmptyString:data.img_url]) {
            NSURL *imageURL = [NSURL URLWithString:[data.img_url stringByAddingPercentEscapesUsingEncoding:
                                                    NSUTF8StringEncoding]];
            
        [iv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [cell.contentView addSubview:iv];
        } 
        
        if ([Common isNotEmptyString:data.item_name]) {
            UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(100,20,self.viewSize.width - 110,40)];
            textLbl.text = data.item_name;
            textLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
            textLbl.alpha = 1.0f;
            textLbl.backgroundColor = [UIColor clearColor];
            textLbl.numberOfLines = 2;
            [cell.contentView addSubview:textLbl];
        }
        
        if ([Common isNotEmptyString:data.item_price]) {
            
            
            UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width - 200,55,180,40)];
            priceLbl.text = [NSString stringWithFormat:@"%@円",[Common formatOfCurrencyWithString:data.item_price] ];
            priceLbl.font = [UIFont fontWithName:@"AppleGothic" size:13];
            priceLbl.alpha = 1.0f;
            priceLbl.textAlignment = NSTextAlignmentRight;
            priceLbl.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:priceLbl];
        }
        
        if ([Common isNotEmptyString:data.stock]) {
            UILabel *stockLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width - 165,65,60,20)];
            stockLbl.text = [NSString stringWithFormat:@"%@",data.stock];
            if ([stockLbl.text isEqualToString:@"売り切れ"]) {
                stockLbl.textColor = [UIColor whiteColor];
                stockLbl.backgroundColor = [UIColor grayColor];
                stockLbl.textAlignment = NSTextAlignmentCenter;
            } else {
                stockLbl.textColor = [UIColor blackColor];
                stockLbl.backgroundColor = [UIColor clearColor];
                stockLbl.textAlignment = NSTextAlignmentRight;
            }
            stockLbl.font = [UIFont boldSystemFontOfSize:10];
            stockLbl.alpha = 1.0f;
            
            [cell.contentView addSubview:stockLbl];
        }
        
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
        return self.itemRecipient.list.count;
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
        if([self.itemRecipient.list count] > indexPath.row){
            ItemData *data = [self.itemRecipient.list objectAtIndex:indexPath.row];
            [self pushNextViewWidhData:data];
        }
        
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
    
    [iv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
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
    if (self.searchType != category || ![PieceCoreConfig isDispSearchBar]) {
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
    self.itemRecipient.list = [NSMutableArray array];
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
            [param setValue:[NSNumber numberWithInt:(int)self.itemRecipient.list.count] forKey:@"get_list_num"];
            break;
        case barcode:
            sendId = SendIdItemBarcode;
            [param setValue:self.code forKey:@"barcode_num"];
            [param setValue:[NSNumber numberWithInt:(int)self.itemRecipient.list.count] forKey:@"get_list_num"];
            break;
        case serchWord:
            sendId = SendIdItemBarcode;
            [param setValue:self.searchWord forKey:@"sarch_word"];
            [param setValue:[NSNumber numberWithInt:(int)self.itemRecipient.list.count] forKey:@"get_list_num"];
            break;
            
        default:
            sendId = SendIdItem;
            [param setValue:self.code forKey:@"category_id"];
            [param setValue:self.searchBar.text forKey:@"sarch_word"];
            [param setValue:[NSNumber numberWithInt:(int)self.itemRecipient.list.count] forKey:@"get_list_num"];
            break;
    }
    [conecter sendActionSendId:sendId param:param];
    
}

-(void)setDataWithRecipient:(ItemRecipient *)recipient sendId:(NSString *)sendId{
    
    if (self.isSearchedMore) {
        [self.itemRecipient.list addObjectsFromArray: recipient.list];
    } else {
        self.itemRecipient = recipient;
        if (self.searchType == serchWord && recipient.list.count <= 0) {
            [self showAlert:@"確認" message:@"検索にヒットする商品はありませんでした。"];
            [self.navigationController popViewControllerAnimated:YES];
        }
            
    }
    if (recipient.more_flg) {
        self.isMore = YES;
    } else {
        self.isMore = NO;
    }
    self.isSearchedMore = NO;
    if (self.itemRecipient.list.count == 1) {
        if (self.isNext) {
            self.isNext = NO;
            ItemData *data = [self.itemRecipient.list objectAtIndex:0];
            [self pushNextViewWidhData:data];
        } else {
            NSInteger count = self.navigationController.viewControllers.count - 2;
            CategoryViewController *vc = [self.navigationController.viewControllers objectAtIndex:count];
            [self.navigationController popToViewController:vc animated:YES];
        }
        
    }
    self.quanitityLbl.text = [NSString stringWithFormat:@"アイテム数：%@",self.itemRecipient.quantity];
    [self.table reloadData];
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [ItemRecipient alloc];
}

-(void)pushNextViewWidhData:(ItemData*)data{
    

    if (![PieceCoreConfig isLinePay] && ![PieceCoreConfig isPayPal]) {

        
        WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:data.item_url];
        [self presentViewController:vc animated:YES completion:nil];
        self.isCloseWebview = YES;
    } else if ([PieceCoreConfig isLinePay]) {
        //linepay_flagがYESの時、ネイティブのビューを作成
        linepay_ViewController *vc = [[linepay_ViewController alloc] initWithNibName:@"linepay_ViewController" bundle:nil];
        
        //商品の名前を格納
        vc.item_name = data.item_name;
        vc.productId = data.item_id;
        //商品画像格納
        vc.img_url = data.img_url;
        UIImageView *item_Image = [[UIImageView alloc] init];
        NSURL *imageURL = [NSURL URLWithString:[data.img_url stringByAddingPercentEscapesUsingEncoding:
                                                NSUTF8StringEncoding]];
        item_Image.frame = CGRectMake(60, 150, 200, 200);
        [item_Image setImageWithURL:imageURL
                   placeholderImage:nil
                            options:SDWebImageCacheMemoryOnly
        usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        vc.itemImgUrl = data.img_url;
        
        //商品説明格納
        vc.item_text = data.item_text;
        
        //商品価格格納
        vc.item_price = data.item_price;
        
        //画面遷移格納
        [self.navigationController pushViewController:vc  animated:YES];
        return;
    } else if ([PieceCoreConfig isPayPal]) {
        //paypalテストようにlainpayを使っている
        PaypalViewController *vc = [[PaypalViewController alloc] initWithNibName:@"PaypalViewController" bundle:nil];
        
        //商品の名前を格納
        vc.item_name = data.item_name;
        vc.item_id = data.item_id;
        //商品画像格納
        vc.img_url = data.img_url;
        UIImageView *item_Image = [[UIImageView alloc] init];
        NSURL *imageURL = [NSURL URLWithString:[data.img_url stringByAddingPercentEscapesUsingEncoding:
                                                NSUTF8StringEncoding]];
        item_Image.frame = CGRectMake(60, 150, 200, 200);
        [item_Image setImageWithURL:imageURL
                   placeholderImage:nil
                            options:SDWebImageCacheMemoryOnly
        usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //vc.itemImgUrl = data.img_url;
        
        //商品説明格納
        vc.item_text = data.item_text;
        
        //商品価格格納
        vc.item_price = data.item_price;
        
        //画面遷移格納
        [self.navigationController pushViewController:vc  animated:YES];

    }
}





@end
