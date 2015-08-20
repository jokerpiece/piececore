//
//  NewsListViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/22.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//
#import "DLog.h"
#import "BaseViewController.h"
#import "InfoRecipient.h"
#import "CouponViewController.h"
#import "FlyerViewController.h"
#import "NewsViewController.h"



@interface InfoListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
@property (weak, nonatomic) IBOutlet UIButton *fliyerBtn;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) InfoRecipient *infoRecipient;
@property (strong, nonatomic) NSArray *fillterList;
@property (strong, nonatomic) NSString *infoId;
@property (weak, nonatomic) IBOutlet UIButton *couponBtn;
- (IBAction)allAction:(id)sender;
- (IBAction)newsAction:(id)sender;
- (IBAction)fliyerAction:(id)sender;
- (IBAction)couponAction:(id)sender;
@end
