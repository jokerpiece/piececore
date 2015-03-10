//
//  WebViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController


- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"WebViewController" owner:self options:nil];
}

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle url:(NSString*)url
{
    self = [super initWithNibName:nibName bundle:nil];
    if (!self) {
        self.url = url;
        return nil;
    }
    // write something.
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"商品詳細";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webview = [[UIWebView alloc] init];
    self.webview.delegate = self;
    self.webview.frame = CGRectMake(0, NavigationHight, self.viewSize.width, self.viewSize.height - TabbarHight - NavigationHight);
    self.webview.scalesPageToFit = YES;
    [self.view addSubview:self.webview];
    if ([Common isNotEmptyString:self.url]) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [self.webview loadRequest:req];
    }
}


@end
