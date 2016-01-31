//
//  HomeViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/10.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "FlyerViewController.h"
@interface FlyerViewController ()

@end

@implementation FlyerViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"FlyerViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic
{
    [self setCartBtn];
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].flyerTitle;
    }
    self.headerHeight = self.viewSize.height * 0.35;
    self.bodyWidh = self.viewSize.width * 0.5;
    self.pageControllHeight = self.headerHeight * 0.15;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.allowsSelection = NO;
    self.timer =
    [NSTimer
     scheduledTimerWithTimeInterval:TimeSlidershow * 1.0f
     target:self
     selector:@selector(nextSlideShow:)
     userInfo:nil
     repeats:YES
     ];
    self.isDispSurvey = [self checkDispSurvry];
    [Common saveLoginDate];
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
    }
    
}

- (void)viewWillAppearLogic
{
    self.isResponse = NO;
    [self syncAction];
    if (!self.timer.isValid) {
        self.timer =
        [NSTimer
         scheduledTimerWithTimeInterval:TimeSlidershow * 1.0f
         target:self
         selector:@selector(nextSlideShow:)
         userInfo:nil
         repeats:YES
         ];
    };
    
    if (self.isDispSurvey) {
        self.isDispSurvey = NO;
        SurveyViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"id_survey"];
        controller.delegate = self;
        
        [self presentViewController:controller
                           animated:YES
                         completion:NULL];
    }
    
    
    
}

- (void)viewWillDisappearLogic
{
    if (self.timer.isValid) {
        [self.timer invalidate];
    };
    self.fliyerId = @"";
}

-(void)createSlider{
    
    self.scroll = [[UIScrollView alloc] init];
    self.pageSize = (int)self.flyerRecipient.headerList.count; // ページ数
    
    // UIScrollViewのインスタンス化
    self.scroll.frame = self.view.bounds;
    
    // 横スクロールのインジケータを非表示にする
    self.scroll.showsHorizontalScrollIndicator = YES;
    
    // ページングを有効にする
    self.scroll.pagingEnabled = YES;
    
    self.scroll.userInteractionEnabled = YES;
    self.scroll.delegate = self;
    
    // スクロールの範囲を設定
    [self.scroll setContentSize:CGSizeMake((self.pageSize * self.viewSize.width), self.headerHeight)];
    self.scroll.frame = CGRectMake(0, 0, self.viewSize.width, self.headerHeight);
    
    int i=0;
    // スクロールビューにラベルを貼付ける
    for (FlyerHeaderData *data in self.flyerRecipient.headerList) {
        NSURL *imageURL = [NSURL URLWithString:data.img_url];
        //UIImage *placeholderImage = [UIImage imageNamed:@"wait.jpg"];
        
        UIImageView *iv = [[UIImageView alloc] init];
        [iv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        iv.frame = CGRectMake(i * self.viewSize.width, 0, self.viewSize.width, self.headerHeight);
        iv.userInteractionEnabled = YES;
        [iv addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self action:@selector(view_Tapped:)]];
        iv.tag = i;
        [self.scroll addSubview:iv];
        i ++;
    }
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.viewSize.width, self.pageControllHeight)];
    
    self.page.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.page.pageIndicatorTintColor = [UIColor darkGrayColor];
    // ページ数を設定
    self.page.numberOfPages = self.pageSize;
    
    // 現在のページを設定
    self.page.currentPage = 0;
    
    // ページコントロールをタップされたときに呼ばれるメソッドを設定
    self.page.userInteractionEnabled = YES;
    [self.page addTarget:self
                  action:@selector(pageControl_Tapped:)
        forControlEvents:UIControlEventValueChanged];
    
    
    if (!self.timer.isValid) {
        [self.timer fire];
    }
    
}

//スライドショーで次の写真を表示する
- (void)nextSlideShow:(NSTimer*)timer
{
    if (self.page.currentPage >= self.pageSize - 1) {
        self.page.currentPage = 0;
    } else {
        self.page.currentPage ++;
    }
    
    CGRect frame = self.scroll.frame;
    frame.origin.x = frame.size.width * self.page.currentPage;
    [self.scroll scrollRectToVisible:frame animated:YES];
}


/**
 * スクロールビューがスワイプされたとき
 * @attention UIScrollViewのデリゲートメソッド
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scroll.frame.size.width;
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        self.page.currentPage = scrollView.contentOffset.x / pageWidth;
    }
}

/**
 * ページコントロールがタップされたとき
 */
- (void)pageControl_Tapped:(id)sender
{
    CGRect frame = self.scroll.frame;
    frame.origin.x = frame.size.width * self.page.currentPage;
    [self.scroll scrollRectToVisible:frame animated:YES];
}


- (void)view_Tapped:(UITapGestureRecognizer *)sender
{
    FlyerHeaderData *data = [self.flyerRecipient.headerList objectAtIndex:sender.view.tag];
    
    if ([Common isNotEmptyString:data.item_url]) {
        
        WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:data.item_url];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIView *childView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.viewSize.width,self.headerHeight)];
        UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(0,self.headerHeight * 0.8,self.viewSize.width,self.pageControllHeight)];
        pageView.backgroundColor = [UIColor clearColor];
        [pageView addSubview:self.page];
        [childView addSubview:self.scroll];
        if (self.flyerRecipient.headerList.count > 1) {
            [childView addSubview:pageView];
        }
        
        [cell.contentView addSubview:childView];
        return cell;
        
    } else if (indexPath.section == 1) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIView *childView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.viewSize.width,self.bodyWidh)];
        int cellNo = 2 * (int)indexPath.row;
        
        for (int i=0; i < 2; i++) {
            cellNo += i;
            
            //if (cell == nil) {
            
            if (indexPath.row * 2 + i >= self.flyerRecipient.bodyList.count) {
                break;
            }
            int currentRow = (int)indexPath.row * 2 + i;
            FlyerBodyData *data = [self.flyerRecipient.bodyList objectAtIndex:currentRow];
            UIImageView *iv = [[UIImageView alloc] init];
            iv.frame = CGRectMake(i * self.bodyWidh, 0, self.bodyWidh, self.bodyWidh);
            
            NSURL *imageURL = [NSURL URLWithString:@""];
            if (![data.img_url isEqual:[NSNull null]]) {
                imageURL = [NSURL URLWithString:data.img_url];
            }
            
            
            [iv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            iv.tag = currentRow;
            [self touchEnableImgview:iv];
            [childView addSubview:iv];
        }
        
        [cell.contentView addSubview:childView];
        
        return cell;
    } else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.searchBtn.frame = CGRectMake( 10, 10, self.viewSize.width - 20, 40 );
            [[self.searchBtn layer]setCornerRadius:15.0f];
            [self.searchBtn setClipsToBounds:YES];
            self.searchBtn.backgroundColor = [UIColor grayColor];
            self.searchBtn.tintColor = [UIColor whiteColor];
            [self.searchBtn setTitle:@"他の商品を見る" forState:UIControlStateNormal];
            [self.searchBtn addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside ];
            self.searchBtn.alpha = 0;
            [cell.contentView addSubview:self.searchBtn];
        }
        return cell;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearchBtnInvisible) {
        return 2;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.headerHeight;
    } else if (indexPath.section == 1){
        return self.bodyWidh;
    } else {
        return 80.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if(section == 1) {
        if (self.flyerRecipient.bodyList.count == 0) {
            return 0;
        }
        float recordNum = self.flyerRecipient.bodyList.count/2.0f;
        return (int)ceil(recordNum) ;
    } else {
        return 1;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void)touchEnableImgview:(UIImageView *)iv{
    iv.userInteractionEnabled = YES;
    iv.multipleTouchEnabled = YES;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(touchImg:)]];
}

-(void)touchImg: (UITapGestureRecognizer *)sender{
    
    FlyerBodyData *data = [self.flyerRecipient.bodyList objectAtIndex:sender.view.tag];
    
    if ([Common isNotEmptyString:data.item_url]) {
        
        WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:data.item_url];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- ( void )onTapButton:( id )sender
{
    if ([PieceCoreConfig tabnumberShopping]) {
        
        UITabBarController* resultsTab =
        (UITabBarController*)[[self.tabBarController viewControllers] objectAtIndex:[PieceCoreConfig tabnumberShopping].intValue];
        
        //遷移先へ移動
        [self.tabBarController setSelectedViewController: resultsTab];
    }
}

-(BOOL)checkDispSurvry{
    if (DispSurveyDate < 0) {
        return NO;
    }
    NSDate *loginDate = [Common loadLoginDate];
    if (loginDate == nil) {
        [Common saveLoginDate];
        return NO;
    }
    
    NSDate *nowDate = [NSDate date];
    NSDate *priodDate = [[NSDate alloc] initWithTimeInterval:DispSurveyDate * 24 * 60 * 60 sinceDate:loginDate];
    NSComparisonResult result = [nowDate compare:priodDate];
    if (result == NSOrderedDescending
        || priodDate == nil) {
        return YES;
    } else {
        return NO;
    }
}

-(void)closeSurveyView{
    if (!self.timer.isValid) {
        self.timer =
        [NSTimer
         scheduledTimerWithTimeInterval:TimeSlidershow * 1.0f
         target:self
         selector:@selector(nextSlideShow:)
         userInfo:nil
         repeats:YES
         ];
    };
}

-(void)syncAction{
    if (![Common isNotEmptyString:self.fliyerId]) {
        self.fliyerId = @"";
    }
    [self syncFliyerAction];

}

-(void)syncFliyerAction{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.fliyerId forKey:@"flyer_id"];
    [conecter sendActionSendId:SendIdFlyerList param:param];
}

-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    
    if ([sendId isEqualToString:SendIdNewsList]) {
        InfoRecipient *infoData = (InfoRecipient *)recipient;
        //最新のチラシを取得
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"type", @"2"];
        NSArray *fliyerList = [infoData.list filteredArrayUsingPredicate:predicate];
        if (fliyerList.count > 0) {
            InfoListData *data = [fliyerList objectAtIndex:0];
            self.fliyerId = data.typeId;
            [self syncFliyerAction];
        }
        
    } else {
        self.flyerRecipient = (FlyerRecipient *)recipient;
        [self createSlider];
        [self.table reloadData];
        if (!self.isSearchBtnInvisible) {
            self.searchBtn.alpha = 1.0f;
        }

    }
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdNewsList]) {
        return [InfoRecipient alloc];
    } else {
        return [FlyerRecipient alloc];
    }
}

@end
