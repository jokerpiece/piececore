//
//  JobViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/15.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SettingData.h"
#import "BaseViewController.h"

@interface JobViewController : BaseViewController
@property (nonatomic,strong) SettingData * setting;
- (IBAction)submit1Action:(id)sender;
- (IBAction)submit2Action:(id)sender;
- (IBAction)submit3Action:(id)sender;
- (IBAction)submit4Action:(id)sender;
- (IBAction)submit5Action:(id)sender;
- (IBAction)submit6Action:(id)sender;
@end
