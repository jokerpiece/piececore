//
//  SCSimpleSLRequestDemo.h
//  pieceSample
//
//  Created by ohnuma on 2015/09/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>
#import "TwitterTableViewCell.h"
#import "DLog.h"

@interface SCSimpleSLRequestDemo : UITableViewController

@property (nonatomic) ACAccountStore *accountStore;
@property (nonatomic, strong) NSDictionary *timeLineData;
@property (nonatomic, strong) NSArray *tweetTxtArray;
@property (nonatomic, strong) NSString *userNameArray;
@property (nonatomic, strong) NSString *tweetIconArray;

- (void)setTwitterUserInfo;

@end
