//
//  ModalWebViewViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/12/25.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "WebViewController.h"

@interface ModalWebViewViewController : WebViewController
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
