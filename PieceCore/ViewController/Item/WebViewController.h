//
//  WebViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WebViewSettingData.h"
#import "SVProgressHUD.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic) WebViewSettingData *setting;
@property (nonatomic) float browserPositionY;
//@property (nonatomic) UIButton *backBtn;
//@property (nonatomic) UIButton *nextBtn;
@property (nonatomic) bool isCancel;
@property (nonatomic) int loadCount;
@property (nonatomic) float beginScrollOffsetY;
@property (nonatomic) int alertBtn;
@property (nonatomic) int tapCount;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadBtn;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle webSetting:(WebViewSettingData *)setting;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle url:(NSString*)url;
- (IBAction)closeAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)reloadAction:(id)sender;

@end
