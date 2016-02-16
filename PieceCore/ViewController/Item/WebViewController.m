//
//  WebViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "WebViewController.h"
#import "SosialViewController.h"

@interface WebViewController ()
@property(nonatomic)bool isSns;
@end

@implementation WebViewController
#define MAX_TAP_COUNT 3
typedef enum {
    loadStop = 0,
    Reload
} alertBtn;


- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"WebViewController" owner:self options:nil];
}

-(void)setNavigationBtn{
    
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                                action:@selector(closeAction:)];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(backAction:)];
    
    
    
    self.navigationItem.leftBarButtonItems = @[closeBtn, backBtn];
}
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle webSetting:(WebViewSettingData *)setting
{
    self = [super initWithNibName:nibName bundle:nil];
    if (!self) {
        return nil;
    }
    // write something.
    self.setting = setting;
    self.isCancel = NO;
    return self;
}

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle url:(NSString*)url{
    self = [super initWithNibName:nibName bundle:nil];
    if (!self) {
        return nil;
    }
    self.setting = [[WebViewSettingData alloc]init];
    // write something.
    self.setting.url = url;
    self.isCancel = NO;
    return self;
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backAction:(id)sender {
    [self.webView goBack];
}

- (IBAction)nextAction:(id)sender {
    [self.webView goForward];
}

- (IBAction)reloadAction:(id)sender {
    [self.webView reload];
}


- (void)viewDidLoadLogic
{
    if (self.title.length < 1) {
        self.navigation.title = [PieceCoreConfig titleNameData].webViewTitle;
    }
    //[self setNavigationBtn];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
//    tap.numberOfTapsRequired = 1;
//    tap.delegate = self;
//    [self.webView addGestureRecognizer:tap];
    
//    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
//    [self.webView addGestureRecognizer:recognizer];
    
    //[self setBlowserBtn];
    
    if ([Common isNotEmptyString:self.setting.url]) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.setting.url]];
        [self.webView loadRequest:req];
    }
    [self addCookies];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (void)onTapped:(UITapGestureRecognizer *)recognizer {
    
    self.alertBtn = Reload;
    if (self.isCancel) {
        [[[UIAlertView alloc] initWithTitle:@"読み込みが途中で中止しました。"
                                    message:@"再読み込みしますか？"
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil] show];
    }
}

-(void)viewWillAppearLogic{
    self.webView.scrollView.delegate = self;
    if (self.setting.isReloadEveryTime) {
        if ([Common isNotEmptyString:self.setting.url]) {
            NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.setting.url]];
            [self.webView loadRequest:req];
        }
    }
    
    if (self.webView.canGoForward && self.setting.isDispBrowserNextBtn) {
        [self setShowBtn:self.nextBtn ButtonVisible:YES];
    } else {
        [self setShowBtn:self.nextBtn ButtonVisible:NO];
    }
    
    if (self.webView.canGoBack && self.setting.isDispBrowserNextBtn) {
        [self setShowBtn:self.backBtn ButtonVisible:YES];
    } else {
        [self setShowBtn:self.backBtn ButtonVisible:NO];
    }
    
    
}

//スクロールビューをドラッグし始めた際に一度実行される
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    self.beginScrollOffsetY = [scrollView contentOffset].y;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    if (self.beginScrollOffsetY < [scrollView contentOffset].y) {
//        //スクロール前のオフセットよりスクロール後が多い=下を見ようとした =>スクロールバーを隠す
//        self.backBtn.alpha = 0.0f;
//        self.nextBtn.alpha = 0.0f;
//        
//    } else if ([scrollView contentOffset].y < self.beginScrollOffsetY
//               && 0.0 != self.beginScrollOffsetY) {
//        if (self.webView.canGoForward && self.setting.isDispBrowserNextBtn) {
//            self.nextBtn.alpha = 0.8f;
//        } else {
//            self.nextBtn.alpha = 0;
//        }
//        
//        if (self.webView.canGoBack && self.setting.isDispBrowserNextBtn) {
//            self.backBtn.alpha = 0.8f;
//        } else {
//            self.backBtn.alpha = 0;
//        }
//    }
//}

-(void)setShowBtn:(UIBarButtonItem *)button ButtonVisible:(bool)ButtonVisible{
    if(ButtonVisible)
    {
        button.tintColor = nil;
        [button setEnabled:YES];
    } else {
        button.tintColor = [UIColor colorWithWhite:0 alpha:0];
        [button setEnabled:NO];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        if (self.alertBtn == Reload) {
            self.isCancel = NO;
            [self.webView reload];
        } else {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDDidReceiveTouchEventNotification object:nil];
            [SVProgressHUD dismiss];
            [self.webView stopLoading];
            self.isCancel = YES;
        }
    }
}

//-(void)setBlowserBtn{
//    
//    if (!self.setting.isDispBrowserBackBtn && !self.setting.isDispBrowserNextBtn) {
//        return;
//    }
//    
//    float positionY = 0.0;
//    if (self.setting.browserBtnPosition == BrowserBtnPositionUp) {
//        positionY = NavigationHight + 10;
//    } else if (self.setting.browserBtnPosition == BrowserBtnPositionMiddle){
//        positionY = self.viewSize.height * 0.5;
//    } else if (self.setting.browserBtnPosition == BrowserBtnPositionDown) {
//        positionY = self.viewSize.height - TabbarHight - NavigationHight;
//    }
//    
//    if (self.setting.isDispBrowserBackBtn) {
//        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.backBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
//        self.backBtn.frame = CGRectMake(0, positionY, 35, 64);
//        
//        [self.backBtn addTarget:self
//                         action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.backBtn.alpha = 0;
//        [self.view addSubview:self.backBtn];
//    }
//    
//    if (self.setting.isDispBrowserNextBtn) {
//        self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.nextBtn setImage:[UIImage imageNamed:@"nextBtn.png"] forState:UIControlStateNormal];
//        self.nextBtn.frame = CGRectMake(self.viewSize.width -35, positionY, 35, 64);
//        
//        [self.nextBtn addTarget:self
//                         action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.nextBtn.alpha = 0;
//        [self.view addSubview:self.nextBtn];
//    }
//    
//}
//- (IBAction)backAction:(id)sender{
//    [self.webView goBack];
//}
//- (IBAction)nextAction:(id)sender{
//    [self.webView goForward];
//}


// ページ読込開始直後に呼ばれるデリゲートメソッド
- (void)webViewDidStartLoad:(UIWebView *)webView
{

    if (self.setting.maskType != 0 && self.loadCount == 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudTapped:) name:SVProgressHUDDidReceiveTouchEventNotification object:nil];

        [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
        [SVProgressHUD setForegroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0]];
        [SVProgressHUD showWithStatus:@"読み込み中…" maskType:self.setting.maskType];
    }
    self.loadCount ++;
    
}
- (void)hudTapped:(NSNotification *)notification
{
    

    if (self.loadCount <= 0) {
        return;
    }
    self.tapCount ++;
    
    if (self.tapCount > MAX_TAP_COUNT) {
//        self.alertBtn = loadStop;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認"
//                                                        message:@"読み込みを中止しますか？"
//                                                       delegate:self
//                                              cancelButtonTitle:@"いいえ"
//                                              otherButtonTitles:@"はい", nil];
//        [alert show];

    }
    
    
}

// ページ読込終了直後に呼ばれるデリゲートメソッド
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    self.loadCount --;
    if (self.setting.maskType != 0 && self.loadCount <= 0) {
        self.tapCount = 0;
        [SVProgressHUD dismiss];
        [NSNotificationCenter.defaultCenter removeObserver:self];
    }
    
    //    if (self.sosialSetting == nil) {
    //        self.sosialSetting = [[SosialSettingData alloc]init];
    //    }
    //    self.sosialSetting.shareMessage = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //    self.sosialSetting.shareUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    
    for (id key in [self.setting.couponInputDomList keyEnumerator]) {
        if ( [[webView stringByEvaluatingJavaScriptFromString:@"document.URL"] hasPrefix:key]) {
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@ = %@",[self.setting.couponInputDomList valueForKey:key],[PieceCoreConfig useCouponNum]]];
            break;
        }
    }
    
    if (webView.canGoForward) {
        [self setShowBtn:self.nextBtn ButtonVisible:YES];
    } else {
        [self setShowBtn:self.nextBtn ButtonVisible:NO];
    }
    
    if (webView.canGoBack) {
       [self setShowBtn:self.backBtn ButtonVisible:YES];
    } else {
        [self setShowBtn:self.backBtn ButtonVisible:NO];
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.loadCount --;
    if (self.setting.maskType != 0) {
        self.tapCount = 0;
        [SVProgressHUD dismiss];
    }
    if ([error code] == NSURLErrorCancelled) {
        return;
    }
    NSString *errMsg;
    switch (error.code) {
        case NSURLErrorBadServerResponse:
            errMsg = @"現在メンテナンス中です。\n大変申し訳ありませんがしばらくお待ち下さい。";
            break;
        case NSURLErrorTimedOut:
            errMsg = @"通信が混み合っています。\nしばらくしてからアクセスして下さい。";
            break;
            
        case kCFURLErrorNotConnectedToInternet:
            errMsg = @"通信できませんでした。\n電波状態をお確かめ下さい。";
            break;
        default:
            return;
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                    message:errMsg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType == UIWebViewNavigationTypeLinkClicked || UIWebViewNavigationTypeFormSubmitted) {
        NSString *scheme = [[request URL] scheme];
        if ([scheme isEqualToString:@"http"] ||
            [scheme isEqualToString:@"https"]) {
            self.isCancel = NO;
        }
    }
    return YES;
}

-(void)addCookies
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud stringForKey:@"uuid"];
    
    if (token == nil) {
        return;
    }
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSDictionary *properties = @{NSHTTPCookieName   : @"uuid",
                                 NSHTTPCookieValue  : [Common getUuid],
                                 NSHTTPCookiePath   : @"/",
                                 NSHTTPCookieDomain : [PieceCoreConfig cookieDomainName],
                                 NSHTTPCookieExpires: [[NSDate date] dateByAddingTimeInterval:3600]};
    NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:properties];
    [cookieStorage setCookie:cookie];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.webView setDelegate:nil];
    [self.webView stopLoading];
    [self.webView.layer removeAllAnimations];
    [self.webView removeFromSuperview];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

//- (void)closeAction:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (void)dealloc {
//    
//    [self.webView setDelegate:nil];
//    [self.webView stopLoading];
//    [self.webView.layer removeAllAnimations];
//    [self.webView removeFromSuperview];
//    [NSNotificationCenter.defaultCenter removeObserver:self];
//}
@end
