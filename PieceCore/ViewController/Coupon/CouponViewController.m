//
//  CouponViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/26.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CouponViewController.h"

@interface CouponViewController ()

@end

@implementation CouponViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"CouponViewController" owner:self options:nil];
}

-(void)viewDidLoadLogic{
    //self.mode = getCoupon;
    SDWebImageManager.sharedManager.delegate = self;
    self.getCoupnBtnRactHeight = self.viewSize.height * 0.57;
    self.chengeCoupnTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chengeCoupnTypeBtn.frame = CGRectMake(30, 0, 90, 30);
    [self.chengeCoupnTypeBtn setTitle:@"クーポンを使う" forState:UIControlStateNormal];
    [self.chengeCoupnTypeBtn setBackgroundColor:[UIColor colorWithRed:1.00 green:0.46 blue:0.03 alpha:1.0]];
    [self.chengeCoupnTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chengeCoupnTypeBtn addTarget:self action:@selector(changeCoupnTypeAction:)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.chengeCoupnTypeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:11]];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithCustomView:self.chengeCoupnTypeBtn];
    
    // ナビゲーションバーの左側に追加する。
    self.navigationItem.rightBarButtonItem = barbtn;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppearLogic
{
    DLog(@"受け取りcouponID:%@",self.couponId);
    if (self.mode == useCoupon) {
        [self dispUseCouponMode];
    } else {
        [self dispGetCouponMode];
    }
    [self syncAction];}


-(void)getCouponAction:(NSString *)coupnId{
    self.isResponse = NO;
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [param setValue:coupnId forKey:@"coupon_id"];
    
    [conecter sendActionSendId:SendIdGetCoupon param:param];
    
}

-(void)createSlider{
    for(UIView* view in self.scroll.subviews) {
        [view removeFromSuperview];
    }
    [self.page removeFromSuperview];
    self.scroll = nil;
    self.page = nil;
    
    
    self.scroll = [[UIScrollView alloc] init];
    self.scroll.bounces = NO;
    self.pageSize = (int)self.data.list.count; // ページ数
    CGFloat width = self.viewSize.width;
    CGFloat height = self.viewSize.height - NavigationHight - TabbarHight;
    
    // UIScrollViewのインスタンス化
    
    self.scroll.frame = self.view.bounds;
    
    // 横スクロールのインジケータを非表示にする
    self.scroll.showsHorizontalScrollIndicator = YES;
    
    // ページングを有効にする
    self.scroll.pagingEnabled = YES;
    
    self.scroll.userInteractionEnabled = YES;
    self.scroll.delegate = self;
    
    // スクロールの範囲を設定
    [self.scroll setContentSize:CGSizeMake((self.pageSize * width), height)];
    self.scroll.frame = CGRectMake(0, 0, width, height);
    
    int i=0;
    int currentPage = 0;
    // スクロールビューにラベルを貼付ける
    for (CouponData *model in self.data.list) {
        if (self.couponId.length > 0
            && [self.couponId isEqualToString:model.coupon_code]){
            currentPage = i;
        }
   
        NSURL *imageURL = [NSURL URLWithString:model.img_url];
        //UIImage *placeholderImage = [UIImage imageNamed:@"wait.jpg"];
        
        UIImageView *iv = [[UIImageView alloc] init];
        [iv sd_setImageWithURL:imageURL
              placeholderImage:[UIImage imageNamed:@"wait.jpg"]
                       options:SDWebImageCacheMemoryOnly
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     }];
        
        iv.frame = CGRectMake(i * width, 0, width, height);
        iv.userInteractionEnabled = YES;
        [iv addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self action:@selector(view_Tapped:)]];
        iv.tag = i;
        if (self.mode == getCoupon) {
            UIView *msk = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iv.frame.size.width, iv.frame.size.height)];
            msk.backgroundColor = [UIColor blackColor];
            msk.alpha = 0.4f;
            [iv addSubview:msk];
        }
        [self setButton:iv tag:i];
        [self.scroll addSubview:iv];
        
        i ++;
    }
    // 背景色を設定
    //self.page.backgroundColor = [UIColor blackColor];
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, width, 30)];
    
    self.page.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.0];
    self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.page.pageIndicatorTintColor = [UIColor darkGrayColor];
    // ページ数を設定
    self.page.numberOfPages = self.pageSize;
    
    // 現在のページを設定
    self.page.currentPage = currentPage;
    
    
    // ページコントロールをタップされたときに呼ばれるメソッドを設定
    self.page.userInteractionEnabled = YES;
    [self.page addTarget:self
                  action:@selector(pageControl_Tapped:)
        forControlEvents:UIControlEventValueChanged];
    
    // ページコントロールを貼付ける
    
    [self.mainView addSubview:self.scroll];
    if (self.data.list.count > 1) {
        [self.mainView addSubview:self.page];
    }
    
    
    
}

-(void)setButton:(UIView *)view tag:(int)tag{
    
    if (self.mode == getCoupon) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake( 0, self.getCoupnBtnRactHeight, self.viewSize.width, 65 );
        
        btn.tag = tag;
        UIImage *img = [UIImage imageNamed:@"coupon_get_btn.png"];
        [btn setImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside ];
        btn.alpha = 0.9f;
        [view addSubview:btn];
//        btn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//        [btn setTitle:@"このクーポンをGETする ＞" forState:UIControlStateNormal];
    }
    
    
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
    if(self.mode == useCoupon){
        [self itemSyncAction];
    }

}
- ( void )onTapButton:( id )sender
{
    if (self.isResponse) {
        self.getPage = (int)self.page.currentPage;
        if (self.mode == useCoupon) {
            
        } else {
            UIButton *btn = sender;
            CouponData *coupn = [self.data.list objectAtIndex:btn.tag];
            [self getCouponAction:coupn.coupon_id];
            self.couponId = coupn.coupon_id;
            [self startAnimation:sender];
        }
        
        DLog(@"ボタン押下");
    }
    
}

- (IBAction)changeCoupnTypeAction:(id)sender {
    switch (self.mode) {
        case getCoupon:
            self.mode = useCoupon;
            [self dispUseCouponMode];
            break;
        case useCoupon:
            self.mode = getCoupon;
            [self dispGetCouponMode];
            break;
        default:
            break;
    }
    self.isResponse = NO;
    [self syncAction];
}
-(void)dispUseCouponMode{
    [self.chengeCoupnTypeBtn setTitle:@"クーポンを取得" forState:UIControlStateNormal];
    self.navigationController.navigationBar.topItem.title = @"クーポン使用";
    self.chengeCoupnTypeBtn.backgroundColor = [UIColor colorWithRed:0.18 green:0.31 blue:0.31 alpha:1.0];
    self.messageLbl.text = @"使用できるクーポンを所持していません。";
}
-(void)dispGetCouponMode{
    [self.chengeCoupnTypeBtn setTitle:@"クーポンを使う" forState:UIControlStateNormal];
    self.navigationController.navigationBar.topItem.title = @"クーポン取得";
    self.chengeCoupnTypeBtn.backgroundColor = [UIColor orangeColor];
    self.messageLbl.text = @"申し訳ございません。\n現在、取得できるクーポンがありません。";
}
-(void)startAnimation:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    //アニメーションの対象となるコンテキスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    //アニメーションを実行する時間
    [UIView setAnimationDuration:1.0];
    //アニメーションイベントを受け取るview
    [UIView setAnimationDelegate:self];
    //アニメーション終了後に実行される
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    [btn setFrame:CGRectMake(350,self.getCoupnBtnRactHeight,self.viewSize.width, 65)];
    
    // アニメーション開始
    [UIView commitAnimations];	
}

-(void)endAnimation{
    [self changeCoupnTypeAction:nil];
    
}

-(void)syncAction{
    self.isResponse = NO;
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSString *sendId = @"";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.mode == useCoupon) {
        sendId = SendIdCouponTake;
        [param setValue:[Common getUuid] forKey:@"uuid"];
    } else {
        sendId = SendIdCouponGive;
        [param setValue:[Common getUuid] forKey:@"uuid"];
    }
    [conecter sendActionSendId:sendId param:param];
    
}

-(void)setData:(CouponConnector *)data sendId:(NSString *)sendId{
    
    if ([sendId isEqualToString:SendIdGetCoupon]) {
    } else if([sendId isEqualToString:SendIdItemCoupon]){
        
        if ([PieceCoreConfig tabnumberShopping]) {
            ItemConnector *data = (ItemConnector *)data;
            
            UINavigationController *vc = self.tabBarController.viewControllers[[PieceCoreConfig tabnumberShopping].intValue];
            self.tabBarController.selectedViewController = vc;
            [vc popToRootViewControllerAnimated:NO];
            
            CouponData *couponModel = [self.data.list objectAtIndex:self.getPage];
            
            UIPasteboard *board = [UIPasteboard generalPasteboard];
            [board setValue:[NSString stringWithFormat:@"%@",couponModel.coupon_code] forPasteboardType:@"public.utf8-plain-text"];
            [super showAlert:@"確認" message:@"クーポン番号をコピーしました。\n購入画面でクーポン番号入力欄にペーストして下さい。"];
            
            if (data.list.count != 0) {
                
                [vc.viewControllers[0] performSegueWithIdentifier:@"toItem" sender:nil];
                ItemListViewController * controller = vc.viewControllers[1];
                controller.isNext = YES;
                
                controller.searchType = coupon;
                controller.code = couponModel.coupon_id;
                
                
                
            }
        }
        
    } else{
        self.data = data;
        [self createSlider];
        CGRect frame = self.scroll.frame;
        frame.origin.x = frame.size.width * self.page.currentPage;
        [self.scroll scrollRectToVisible:frame animated:YES];
    }
    
}

//
-(void)itemSyncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSString *sendId;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    CouponData *couponModel = [self.data.list objectAtIndex:self.getPage];
    sendId = SendIdItemCoupon;
    [param setValue:couponModel.coupon_id forKey:@"coupon_id"];
    [param setValue:0 forKey:@"get_list_num"];
    [conecter sendActionSendId:sendId param:param];
    
}

//
-(BaseConnector *)getDataWithSendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdGetCoupon]) {
        return [BaseConnector alloc];
    } else if ([sendId isEqualToString:SendIdItemCoupon]) {
        return [ItemConnector alloc];
    } else {
        return [CouponConnector alloc];
    }
}

-(void)receiveSucceed:(NSDictionary *)receivedData sendId:(NSString *)sendId{
    self.isResponse = YES;
    BaseConnector *data = [[self getDataWithSendId:sendId] initWithResponseData:receivedData];
    //後で外す
    if (data.error_code.intValue != 0){
      //SN  && data.error_code.intValue !=999) {
        [self showAlert:@"エラー" message:data.error_message];
        return;
    }
    if (data.error_message.length > 0) {
        DLog(@"%@",data.error_message);
    }
    [self setData:data sendId:sendId];
    
}
@end
