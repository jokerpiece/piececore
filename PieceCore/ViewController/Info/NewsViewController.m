//
//  NewsViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "NewsViewController.h"
#import "CoreDelegate.h"

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
    
    for(UITableView *cell in self.cellList){
        if ([cell isKindOfClass:[NewsImageViewCell class]]) {
            UINib *nib = [UINib nibWithNibName:@"NewsImageViewCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@""];
        }else if([cell isKindOfClass:[NewsTextViewCell class]]){
            UINib *nib = [UINib nibWithNibName:@"" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@""];
        }else if([cell isKindOfClass:[NewsTextViewCell class]]){
            UINib *nib = [UINib nibWithNibName:@"" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@""];
        }
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
    self.newsRecipient = recipient;
    self.titleLbl.text = self.newsRecipient.title;
    self.textTv.text = self.newsRecipient.text;
    
    NSMutableArray *cell_st = [NSMutableArray array];
    [cell_st addObject:[NewsImageViewCell alloc]];
    [cell_st addObject:[NewsUrlViewCell alloc]];
    [cell_st addObject:[NewsTextViewCell alloc]];
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [NewsRecipient alloc];
}



@end
