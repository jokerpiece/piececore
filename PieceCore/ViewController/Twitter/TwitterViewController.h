//
//  VoteViewController.h
//  pieceSample
//
//  Created by ohnuma on 2015/09/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import "BaseViewController.h"
#import "TwitterTableViewCell.h"
//#import "VoteViewCellTableViewCell.h"

@interface TwitterViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSArray *tweets;
}
@property (weak, nonatomic) IBOutlet UITableView *twitterTableView;
@property (nonatomic, strong) NSString *lankStr;
@property (nonatomic, strong) NSString *textStr;
@property (nonatomic, strong) NSString *imgUrlStr;
@property (nonatomic, strong) NSString *keepingpointStr;
@property (nonatomic, strong) NSString *userAcount;
@property (nonatomic, strong) NSString *twitterCount;
@property (nonatomic, strong) NSString *pointSelect;
@property (nonatomic) UIView *headerV;

-(id)initWithNibName:(NSString*)nibName bundle:bundle;
-(void)setDisplayTwitterData;


@end
