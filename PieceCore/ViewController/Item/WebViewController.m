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
    self.sosialSetting.shareMessage = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.sosialSetting.shareUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
}

- (void)dealloc {
    
    [self.webView setDelegate:nil];
    [self.webView stopLoading];
    [self.webView.layer removeAllAnimations];
    [self.webView removeFromSuperview];
}
@end
