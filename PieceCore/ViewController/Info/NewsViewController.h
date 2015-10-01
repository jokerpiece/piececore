//
//  NewsViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NewsRecipient.h"
#import "WebViewController.h"

@interface NewsViewController : BaseViewController<NetworkDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIView *uv;
@property (nonatomic, strong) UIScrollView *sv;

@property (nonatomic,strong) NSString *news_id;
@property (strong, nonatomic) NewsRecipient *newsRecipient;
@property (weak, nonatomic) IBOutlet UIView *titleBG;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *textTv;
@property (nonatomic) NSMutableArray *cellList;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) NSString *news_text;
@property (nonatomic, strong) NSString *link_title;
@property (nonatomic, strong) NSString *link_title_2;
@property (nonatomic, strong) NSString *link_title_3;
@property (nonatomic, strong) NSString *link_url;
@property (nonatomic, strong) NSString *link_url_2;
@property (nonatomic, strong) NSString *link_url_3;

@end
