//
//  VoteViewController.m
//  pieceSample
//
//  Created by ohnuma on 2015/09/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "TwitterViewController.h"
#import "CoreDelegate.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController

- (id)initWithNibName:(NSString*)nibName bundle:bundle
{
    self = [super initWithNibName:nibName bundle:nil];
    if (!self) {
        return nil;
    }
    // write something.
    //    self.userAcount = @"@SplatoonJP";
    self.twitterCount = @"10";
    return self;
}

- (void)viewDidLoadLogic {
    if(self.title.length < 1){
        self.title = [PieceCoreConfig titleNameData].twitterTitle;
    }
    
    self.twitterTableView.allowsSelection = NO;
    self.twitterTableView.rowHeight = UITableViewAutomaticDimension;
    self.twitterTableView.delegate = self;
    self.twitterTableView.dataSource = self;
    
    self.twitterTableView.tableHeaderView = self.headerV;
    UINib *nib = [UINib nibWithNibName:@"TwitterTableViewCell" bundle:nil];
    [self.twitterTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    [self setDisplayTwitterData];
    
}

-(void)setDisplayTwitterData{
    if (![Common isNotEmptyString:self.userAcount]) {
        return;
    }
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *apiURL = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
    
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType =
    [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [store requestAccessToAccountsWithType:twitterAccountType options:nil completion:^(BOOL granted,NSError *error){
        //Twitterの認証の拒否or認証
        if(!granted){
            DLog(@"Twitterの認証を拒否");
        }else{
            NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
            if ([twitterAccounts count] > 0) {
                ACAccount *account = [twitterAccounts objectAtIndex:0];
                //userAcountで表示するユーザーの指定
                NSDictionary *params = @{@"screen_name" : self.userAcount,
                                         @"include_rts" : @"1",
                                         @"count" : self.twitterCount};
                
                NSURL *url = [NSURL URLWithString:apiURL];
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                        requestMethod:SLRequestMethodGET
                                                                  URL:url parameters:params];
                [request setAccount:account];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                [request performRequestWithHandler:^(NSData *responseData,NSHTTPURLResponse *urlResponse,NSError *error) {
                    if(!responseData){
                        DLog(@"response error: %@", error);
                    }else{
                        NSError *jsonError;
                        tweets = [NSJSONSerialization JSONObjectWithData:responseData
                                                                 options: NSJSONReadingMutableLeaves
                                                                   error:&jsonError];
                        if(tweets){
                            DLog(@"%@",tweets);
                            dispatch_async(dispatch_get_main_queue(), ^{ // 追加
                                [self.twitterTableView reloadData]; // 追加
                            });
                        }else{
                            DLog(@"%@", error);
                        }
                        //Tweet取得完了に伴い、Table Viewを更新
                    }
                }];
            }
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *status = [tweets objectAtIndex:indexPath.row];
    NSString *tweetText = [status objectForKey:@"text"];
    CGSize maxSize = CGSizeMake(200, CGFLOAT_MAX);
    NSDictionary *attr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:12.0]};
    CGSize modifiedSize = [tweetText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
    float cellSize = modifiedSize.height + 28;
    if (cellSize > 74) {
        return cellSize;
    } else {
        return 74;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwitterTableViewCell *cell = [self.twitterTableView dequeueReusableCellWithIdentifier:@"Cell"
                                                                             forIndexPath:indexPath];
    NSDictionary *status = [tweets objectAtIndex:indexPath.row];
    NSString *tweetText = [status objectForKey:@"text"];
    NSDictionary *twitterUser = [status objectForKey:@"user"];
    NSString *twitterUserImgUrl = [twitterUser objectForKey:@"profile_image_url_https"];
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        NSURL *imgURL = [NSURL URLWithString:[twitterUserImgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSData dataWithContentsOfURL:imgURL];
        UIImage *Img = [[UIImage alloc] initWithData:data];
        
        dispatch_async(q_main, ^{
            cell.twitterUserImg.image = Img;
            [cell layoutSubviews];
        });
    });
    
    //経過時間
    NSString *dateStr = status[@"created_at"];
    DLog(@"%@",dateStr);
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc]init];
    [inputFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormat setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *date = [inputFormat dateFromString:dateStr];
    DLog(@"%@",date);
    
    NSDate *nowTime = [NSDate date];
    float tmp = [nowTime timeIntervalSinceDate:date];
    int day = (int)(tmp / 86400);
    int hour = (int)(tmp / 3600);
    int min = (int)(tmp / 60);
    int sec = tmp;
    DLog(@"%@",nowTime);
    DLog(@"%d日%d時間%d分%d秒前",day,hour,min,sec);
    
    NSString *courseTime;
    if(min == 0){
        courseTime = [NSString stringWithFormat:@"now"];
    }else if (hour == 0){
        courseTime = [NSString stringWithFormat:@"%d m",min];
    }else if (hour >= 24){
        courseTime = [NSString stringWithFormat:@"%d d",day];
    }else{
        courseTime = [NSString stringWithFormat:@"%d h",hour];
    }
    
    // カスタムセルのラベルに値を設定
    cell.twitterTextLbl.text = tweetText;
    cell.twitterUserNameLbl.text = [twitterUser objectForKey:@"name"];
    cell.twitterIdLbl.text = self.userAcount;
    cell.twitterTimeLbl.text = courseTime;
    
    return cell;
}

@end
