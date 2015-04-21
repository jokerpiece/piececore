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
        positionY = self.viewSize.height - self.viewSize.height - TabbarHight - NavigationHight;
    }
    
    if (self.setting.isDispBrowserBackBtn) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, positionY, 35, 64);
        
        [backBtn addTarget:self
                    action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
    }
    
    if (self.setting.isDispBrowserNextBtn) {
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setImage:[UIImage imageNamed:@"nextBtn.png"] forState:UIControlStateNormal];
        nextBtn.frame = CGRectMake(self.viewSize.width -35, positionY, 35, 64);
        
        [nextBtn addTarget:self
                    action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nextBtn];
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
    if (self.setting.maskType != 0) {
        [SVProgressHUD showWithMaskType:self.setting.maskType];
    }
    
}

// ページ読込終了直後に呼ばれるデリゲートメソッド
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.setting.maskType != 0) {
        [SVProgressHUD dismiss];
    }
    
    if (self.sosialSetting == nil) {
        self.sosialSetting = [[SosialSettingData alloc]init];
    }
    self.sosialSetting.shareMessage = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.sosialSetting.shareUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    
    for (id key in [self.setting.couponInputDomList keyEnumerator]) {
        DLog(@"Key:%@ Value:%@", key, [self.setting.couponInputDomList valueForKey:key]);
        if ( [[webView stringByEvaluatingJavaScriptFromString:@"document.URL"] hasPrefix:key]) {
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@ = %@",[self.setting.couponInputDomList valueForKey:key],[PieceCoreConfig useCouponNum]]];
            break;
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
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
            errMsg = [NSString stringWithFormat:@"エラーコード：%ld",(long)error.code];
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                    message:errMsg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}
- (void)dealloc {
    
    [self.webView setDelegate:nil];
    [self.webView stopLoading];
    [self.webView.layer removeAllAnimations];
    [self.webView removeFromSuperview];
}
@end
