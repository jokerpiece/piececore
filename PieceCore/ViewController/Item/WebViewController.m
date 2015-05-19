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


- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"WebViewController" owner:self options:nil];
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


- (void)viewDidLoadLogic
{
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].webViewTitle;
    }
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    [self setBlowserBtn];
    
    if ([Common isNotEmptyString:self.setting.url]) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.setting.url]];
        [self.webView loadRequest:req];
    }
}

-(void)viewWillAppearLogic{
    if (self.setting.isReloadEveryTime) {
        if ([Common isNotEmptyString:self.setting.url]) {
            NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.setting.url]];
            [self.webView loadRequest:req];
        }
    }
    if (self.isCancel) {
        [[[UIAlertView alloc] initWithTitle:@"読み込みが途中で中止しました。"
                                    message:@"再読み込みしますか？"
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil] show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        self.isCancel = NO;
        [self.webView reload];
    }
}

-(void)setBlowserBtn{
    
    if (!self.setting.isDispBrowserBackBtn && !self.setting.isDispBrowserNextBtn) {
        return;
    }
    
    float positionY = 0.0;
    if (self.setting.browserBtnPosition == BrowserBtnPositionUp) {
        positionY = NavigationHight + 10;
    } else if (self.setting.browserBtnPosition == BrowserBtnPositionMiddle){
        positionY = self.viewSize.height * 0.5;
    } else if (self.setting.browserBtnPosition == BrowserBtnPositionDown) {
        positionY = self.viewSize.height - TabbarHight - NavigationHight;
    }
    
    if (self.setting.isDispBrowserBackBtn) {
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
        self.backBtn.frame = CGRectMake(0, positionY, 35, 64);
        
        [self.backBtn addTarget:self
                    action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        self.backBtn.alpha = 0;
        [self.view addSubview:self.backBtn];
    }
    
    if (self.setting.isDispBrowserNextBtn) {
        self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nextBtn setImage:[UIImage imageNamed:@"nextBtn.png"] forState:UIControlStateNormal];
        self.nextBtn.frame = CGRectMake(self.viewSize.width -35, positionY, 35, 64);
        
        [self.nextBtn addTarget:self
                    action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        self.nextBtn.alpha = 0;
        [self.view addSubview:self.nextBtn];
    }
    
}
- (IBAction)backAction:(id)sender{
    [self.webView goBack];
}
- (IBAction)nextAction:(id)sender{
    [self.webView goForward];
}


// ページ読込開始直後に呼ばれるデリゲートメソッド
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.loadCount ++;
    if (self.setting.maskType != 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudTapped:) name:SVProgressHUDDidReceiveTouchEventNotification object:nil];
        [SVProgressHUD showWithMaskType:self.setting.maskType];
    }
    
}
- (void)hudTapped:(NSNotification *)notification
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDDidReceiveTouchEventNotification object:nil];
    [SVProgressHUD dismiss];
    [self.webView stopLoading];
    self.isCancel = YES;
}

// ページ読込終了直後に呼ばれるデリゲートメソッド
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    self.loadCount --;
    if (self.setting.maskType != 0 && self.loadCount <= 0) {
        [SVProgressHUD dismiss];
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
        self.nextBtn.alpha = 1.0f;
    } else {
        self.nextBtn.alpha = 0;
    }
    
    if (webView.canGoBack) {
        self.backBtn.alpha = 1.0f;
    } else {
        self.backBtn.alpha = 0;
    }

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.loadCount --;
    if (self.setting.maskType != 0) {
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



- (void)dealloc {
    
    [self.webView setDelegate:nil];
    [self.webView stopLoading];
    [self.webView.layer removeAllAnimations];
    [self.webView removeFromSuperview];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
@end
