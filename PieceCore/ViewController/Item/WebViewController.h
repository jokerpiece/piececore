//
//  WebViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SVProgressHUD.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>
@property (strong, nonatomic) NSString *url;
@property (nonatomic) bool isMask;
@property (nonatomic) SVProgressHUDMaskType maskType;
//@property (strong, nonatomic) UIWebView *webview;

@property (nonatomic) bool isSnsEnable;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle url:(NSString*)url maskType:(SVProgressHUDMaskType)maskType;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle url:(NSString*)url;
@end
