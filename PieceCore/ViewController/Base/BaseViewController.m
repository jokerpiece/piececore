//
//  BaseViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/03.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BaseViewController.h"
#import "CoreDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewSize = [UIScreen mainScreen].bounds.size;
    SDWebImageManager.sharedManager.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithTitle:@"戻る"
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:nil];
    self.navigationItem.backBarButtonItem = btn;
    
    if (self.titleImgName.length > 0) {
        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.titleImgName]];
        self.navigationItem.titleView = titleImageView;
    }
    [self viewDidLoadLogic];
}
-(void)viewDidLoadLogic{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self viewDidAppearLogic];
}

-(void)viewDidAppearLogic{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self viewWillAppearLogic];
    
}

- (void)viewWillAppearLogic
{
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self viewWillDisappearLogic];
}

- (void)viewWillDisappearLogic{
    
}


-(void)receiveSucceed:(NSDictionary *)receivedData sendId:(NSString *)sendId{
    self.isResponse = YES;
    BaseConnector *data = [[self getDataWithSendId:sendId] initWithResponseData:receivedData];
    if (data.error_code.intValue != 0) {
        [self showAlert:@"エラー" message:data.error_message];
     return;
     }
    if (data.error_message.length > 0) {
        DLog(@"%@",data.error_message);
    }
    [self setData:data sendId:sendId];
    
}

-(void)receiveError:(NSError *)error sendId:(NSString *)sendId{
    CoreDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (!delegate.isUpdate) {
        NSString *errMsg;
        switch (error.code) {
            case NSURLErrorBadServerResponse:
                errMsg = @"現在メンテナンス中です。\n大変申し訳ありませんがしばらくお待ち下さい。";
                break;
            case NSURLErrorTimedOut:
                errMsg = @"通信が混み合っています。\nしばらくしてからアクセスして下さい。";
                break;
                
            default:
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:errMsg
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

-(void)setData:(BaseConnector *)data sendId:(NSString *)sendId{
}
-(BaseConnector *)getDataWithSendId:(NSString *)sendId{
    return nil;
}

- (void)timeoutRequest{
    [self showAlert:@"エラー" message:@"通信がタイムアウトしました。時間をおいて再度お試し下さい。"];
}
-(void)showAlert:(BaseConnector *)data {
    if (![data.error_code isEqualToString:@"0"]) {
        [self showAlert:@"エラー" message:data.error_message];
    }
}

-(void)showAlert:(NSString *)title message:(NSString *)message{
    
    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:title
     message:message
     delegate:nil
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil
     ];
    
    [alert show];
    
    
    
}

@end
