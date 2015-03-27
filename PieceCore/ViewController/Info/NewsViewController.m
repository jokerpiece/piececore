//
//  NewsViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"NewsViewController" owner:self options:nil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoadLogic
{
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].newsTitle;
    }
    self.textTv.delegate = self;
}

- (BOOL) textViewShouldBeginEditing: (UITextView*) textView
{
    
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self syncAction];
    [super viewWillAppear:animated];
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.news_id forKey:@"news_id"];
    [conecter sendActionSendId:SendIdNews param:param];
}

-(void)setDataWithRecipient:(NewsRecipient *)recipient sendId:(NSString *)sendId{
    self.recipient = recipient;
    self.titleLbl.text = self.recipient.title;
    self.textTv.text = self.recipient.text;
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [NewsRecipient alloc];
}



@end
