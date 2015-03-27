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
    self.title = [PieceCoreConfig titleNameData].getCouponTitle;
    SDWebImageManager.sharedManager.delegate = self;
    self.getCoupnBtnRactHeight = self.viewSize.height * 0.57;    
    UIImage *img = [UIImage imageNamed:@"coupon_search.png"];
    self.chengeCoupnTypeBtn = [[UIButton alloc]init];
    [self.chengeCoupnTypeBtn setBackgroundImage:img forState:UIControlStateNormal];
    self.chengeCoupnTypeBtn.frame = CGRectMake(30, 0, 80, 30);
    [self.chengeCoupnTypeBtn addTarget:self action:@selector(changeCoupnTypeAction:)
                      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithCustomView:self.chengeCoupnTypeBtn];
    
    self.navigationItem.rightBarButtonItem = barbtn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    self.pageSize = (int)self.recipient.list.count; // ページ数
    CGFloat width = self.viewSize.width;
    CGFloat height = self.viewSize.height - NavigationHight - TabbarHight;
    self.scroll.frame = self.view.bounds;
    self.scroll.showsHorizontalScrollIndicator = YES;
    self.scroll.pagingEnabled = YES;
    
    self.scroll.userInteractionEnabled = YES;
    self.scroll.delegate = self;
    [self.scroll setContentSize:CGSizeMake((self.pageSize * width), height)];
    self.scroll.frame = CGRectMake(0, 0, width, height);
    
    int i=0;
    int currentPage = 0;
    for (CouponData *data in self.recipient.list) {
        if ([Common isNotEmptyString:self.couponId]
            && [self.couponId isEqualToString:data.coupon_code]){
            currentPage = i;
        }
        
        NSURL *imageURL = [NSURL URLWithString:data.img_url];
        UIImageView *iv = [[UIImageView alloc] init];
        [iv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
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
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, width, 30)];
    
    self.page.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.0];
    self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.page.pageIndicatorTintColor = [UIColor darkGrayColor];
    self.page.numberOfPages = self.pageSize;
    
    self.page.currentPage = currentPage;
    
    
    self.page.userInteractionEnabled = YES;
    [self.page addTarget:self
                  action:@selector(pageControl_Tapped:)
        forControlEvents:UIControlEventValueChanged];
    
    [self.mainView addSubview:self.scroll];
    if (self.recipient.list.count > 1) {
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
            CouponData *coupn = [self.recipient.list objectAtIndex:btn.tag];
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
    UIImage *img = [UIImage imageNamed:@"coupon_search.png"];
    [self.chengeCoupnTypeBtn setBackgroundImage:img forState:UIControlStateNormal];
    
    self.navigationController.navigationBar.topItem.title = [PieceCoreConfig titleNameData].useCouponTitle;
    self.chengeCoupnTypeBtn.backgroundColor = [UIColor colorWithRed:0.18 green:0.31 blue:0.31 alpha:1.0];
    self.messageLbl.text = @"使用できるクーポンを所持していません。";
}
-(void)dispGetCouponMode{
    UIImage *img = [UIImage imageNamed:@"coupon_use.png"];
    [self.chengeCoupnTypeBtn setBackgroundImage:img forState:UIControlStateNormal];
    self.navigationController.navigationBar.topItem.title = [PieceCoreConfig titleNameData].getCouponTitle;
    self.chengeCoupnTypeBtn.backgroundColor = [UIColor orangeColor];
    self.messageLbl.text = @"申し訳ございません。\n現在、取得できるクーポンがありません。";
}
-(void)startAnimation:(id)sender{
    UIButton *btn = (UIButton *)sender;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    [btn setFrame:CGRectMake(350,self.getCoupnBtnRactHeight,self.viewSize.width, 65)];
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

-(void)setDataWithRecipient:(CouponRecipient *)recipient sendId:(NSString *)sendId{
    
    if ([sendId isEqualToString:SendIdGetCoupon]) {
    } else if([sendId isEqualToString:SendIdItemCoupon]){
        
        if ([PieceCoreConfig tabnumberShopping]) {
            ItemRecipient *itemRecipient = (ItemRecipient *)recipient;
            
            UINavigationController *vc = self.tabBarController.viewControllers[[PieceCoreConfig tabnumberShopping].intValue];
            self.tabBarController.selectedViewController = vc;
            [vc popToRootViewControllerAnimated:NO];
            
            CouponData *couponModel = [self.recipient.list objectAtIndex:self.getPage];
            
            UIPasteboard *board = [UIPasteboard generalPasteboard];
            [board setValue:[NSString stringWithFormat:@"%@",couponModel.coupon_code] forPasteboardType:@"public.utf8-plain-text"];
            [super showAlert:@"確認" message:@"クーポン番号をコピーしました。\n購入画面でクーポン番号入力欄にペーストして下さい。"];
            
            if (itemRecipient.list.count != 0) {
                
                [vc.viewControllers[0] performSegueWithIdentifier:@"toItem" sender:nil];
                ItemListViewController * controller = vc.viewControllers[1];
                controller.isNext = YES;
                
                controller.searchType = coupon;
                controller.code = couponModel.coupon_id;
            }
        }
        
    } else{
        self.recipient = recipient;
        [self createSlider];
        CGRect frame = self.scroll.frame;
        frame.origin.x = frame.size.width * self.page.currentPage;
        [self.scroll scrollRectToVisible:frame animated:YES];
    }
    
}

-(void)itemSyncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSString *sendId;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    CouponData *couponModel = [self.recipient.list objectAtIndex:self.getPage];
    sendId = SendIdItemCoupon;
    [param setValue:couponModel.coupon_id forKey:@"coupon_id"];
    [param setValue:0 forKey:@"get_list_num"];
    [conecter sendActionSendId:sendId param:param];
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdGetCoupon]) {
        return [BaseRecipient alloc];
    } else if ([sendId isEqualToString:SendIdItemCoupon]) {
        return [ItemRecipient alloc];
    } else {
        return [CouponRecipient alloc];
    }
}

-(void)receiveSucceed:(NSDictionary *)receivedData sendId:(NSString *)sendId{
    self.isResponse = YES;
    BaseRecipient *recipient = [[self getDataWithSendId:sendId] initWithResponseData:receivedData];
    //後で外す
    if (recipient.error_code.intValue != 0){
        //SN  && data.error_code.intValue !=999) {
        [self showAlert:@"エラー" message:recipient.error_message];
        return;
    }
    if (recipient.error_message.length > 0) {
        DLog(@"%@",recipient.error_message);
    }
    [self setDataWithRecipient:(CouponRecipient *)recipient sendId:sendId];
    
}
@end
