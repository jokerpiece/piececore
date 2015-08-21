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
#import "NewsTextViewCell.h"
#import "NewsImageViewCell.h"
#import "NewsUrlViewCell.h"

@interface NewsViewController : BaseViewController<NetworkDelegate, UITextViewDelegate>
@property (nonatomic,strong) NSString *news_id;
@property (strong, nonatomic) NewsRecipient *newsRecipient;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *textTv;
@property (nonatomic) NSMutableArray *cellList;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end
