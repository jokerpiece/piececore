//
//  NewsViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BaseViewController.h"
#import "NewsRecipient.h"

@interface NewsViewController : BaseViewController<NetworkDelegate, UITextViewDelegate>
@property (nonatomic,strong) NSString *news_id;
@property (strong, nonatomic) NewsRecipient *recipient;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *textTv;
@end
