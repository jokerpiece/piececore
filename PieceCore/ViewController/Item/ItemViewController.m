//
//  ItemViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "ItemViewController.h"

@interface ItemViewController ()

@end

@implementation ItemViewController


- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"ItemViewController" owner:self options:nil];
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
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webview loadRequest:req];

}


@end
