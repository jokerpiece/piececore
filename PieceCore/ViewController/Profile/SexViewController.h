//
//  SexViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/15.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SettingData.h"
#import "BaseViewController.h"

@interface SexViewController : BaseViewController
@property (nonatomic,strong) SettingData * setting;
- (IBAction)selectManAction:(id)sender;
- (IBAction)selectWomanAction:(id)sender;
@end
