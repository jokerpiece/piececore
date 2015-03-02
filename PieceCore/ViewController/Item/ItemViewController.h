//
//  ItemViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ItemViewController : BaseViewController<UIWebViewDelegate>
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) UIWebView *webview;
@end
