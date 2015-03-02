//
//  NewsViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BaseViewController.h"
#import "NewsConnector.h"

@interface NewsViewController : BaseViewController<NetworkDelegate, UITextViewDelegate>
@property (nonatomic,strong) NSString *news_id;
@property (strong, nonatomic) NewsConnector *data;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *textTv;
@end
