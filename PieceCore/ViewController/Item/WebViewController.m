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

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle url:(NSString*)url maskType:(SVProgressHUDMaskType)maskType
{
    self = [super initWithNibName:nibName bundle:nil];
    if (!self) {
        return nil;
    }
    // write something.
    self.url = url;
    self.isMask = YES;
    self.maskType = maskType;
    self.isSns = NO;
    return self;
}

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle url:(NSString*)url{
    self = [super initWithNibName:nibName bundle:nil];
    if (!self) {
        return nil;
    }
    // write something.
    self.url = url;
    self.isMask = NO;
    self.maskType = SVProgressHUDMaskTypeBlack;
    return self;
}


- (void)viewDidLoadLogic
{
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    if ([Common isNotEmptyString:self.url]) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:req];
    }
    
    if (self.isSnsEnable) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.viewSize.width * 0.8, self.viewSize.height - TabbarHight - NavigationHight, 50, 50);
        [button setImage:[UIImage imageNamed:@"sns.png"] forState:UIControlStateNormal];
        [button addTarget:self
                action:@selector(moveSns:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}

- (IBAction)backAction:(id)sender{
    [self.webView goBack];
}
- (void)moveSns:(id)sender{
    SosialViewController *vc = [[SosialViewController alloc] initWithNibName:@"SosialViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

// ページ読込開始直後に呼ばれるデリゲートメソッド
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.isMask) {
        [SVProgressHUD showWithMaskType:self.maskType];
    }
    
}

// ページ読込終了直後に呼ばれるデリゲートメソッド
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.isMask) {
        [SVProgressHUD dismiss];
    }
    
}
@end
