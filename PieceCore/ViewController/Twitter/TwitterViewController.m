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
    self.userAcount = @"@ps6963";
    self.twitterCount = @"10";
    self.keepingpointStr = @"500";
    return self;
}

- (void)viewDidLoad {
    if(self.title.length < 1){
        self.title = [PieceCoreConfig titleNameData].twitterTitle;
    }
    
    [super viewDidLoad];
    
    self.twitterTableView.allowsSelection = NO;
    self.twitterTableView.rowHeight = UITableViewAutomaticDimension;
    self.twitterTableView.delegate = self;
    self.twitterTableView.dataSource = self;
    
    UINib *nib2 = [UINib nibWithNibName:@"VoteViewCellTableViewCell" bundle:nil];
    [self.twitterTableView registerNib:nib2 forCellReuseIdentifier:@"Cell1"];
    UINib *nib = [UINib nibWithNibName:@"TwitterTableViewCell" bundle:nil];
    [self.twitterTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *apiURL = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
    
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType =
    [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [store requestAccessToAccountsWithType:twitterAccountType options:nil completion:^(BOOL granted,NSError *error){
        //Twitterの認証の拒否or認証
        if(!granted){
            NSLog(@"Twitterの認証を拒否");
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
                        NSLog(@"response error: %@", error);
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
    if(indexPath.row == 0){
        return 400;

    }else{
        NSDictionary *status = [tweets objectAtIndex:indexPath.row];
        NSString *tweetText = [status objectForKey:@"text"];
        CGSize maxSize = CGSizeMake(200, CGFLOAT_MAX);
        NSDictionary *attr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:12.0]};
        CGSize modifiedSize = [tweetText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
        
        return MAX(modifiedSize.height + 10, 75);
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
    if(indexPath.row == 0){
       
        VoteViewCellTableViewCell *cell = [self.twitterTableView dequeueReusableCellWithIdentifier:@"Cell1"
                                forIndexPath:indexPath];
        cell.keepPointLbl.text = self.keepingpointStr;
        
        [cell.voteBtn addTarget:self
                         action:@selector(handleTounchButton:event:)
               forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        TwitterTableViewCell *cell = [self.twitterTableView dequeueReusableCellWithIdentifier:@"Cell"
                                                                                 forIndexPath:indexPath];
        NSDictionary *status = [tweets objectAtIndex:indexPath.row - 1];
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
        
        //[cell.twitterTextLbl sizeToFit];
//        cell.twitterTextLbl.numberOfLines = 0;
//        cell.twitterTextLbl.lineBreakMode = NSLineBreakByCharWrapping;
        return cell;
    }
}
-(void)handleTounchButton:(UIButton *)sender event:(UIEvent *)event{
    NSUserDefaults *inputPointData = [NSUserDefaults standardUserDefaults];
    NSString *inputPointSave = [inputPointData stringForKey:@"INPUT_POINT"];
    DLog(@"%@",inputPointSave);
    
    //Point入力判定
    if(inputPointSave.integerValue > self.keepingpointStr.integerValue){
        //アラート表示
        UIAlertView *pointOverAlert =
        [[UIAlertView alloc] initWithTitle:@"エラー"
                                   message:@"保持しているPoint以上の値が入力されました。"
                                  delegate:self
                         cancelButtonTitle:@"確認"
                         otherButtonTitles:nil];
        [pointOverAlert show];
    }else{
        NSString *tweetAcountAdd = [self.userAcount stringByAppendingString:@" "];
        SLComposeViewController *vc = [SLComposeViewController
                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
        [vc setInitialText:NSLocalizedString(tweetAcountAdd, nil)];
        [self presentViewController:vc animated:YES completion:nil];
        [vc setCompletionHandler:^(SLComposeViewControllerResult result){
            NSString *tweetResult;
            switch (result) {
                case SLComposeViewControllerResultDone:
                    //成功
                    tweetResult = @"投票しました";
                    break;
                case SLComposeViewControllerResultCancelled:
                    //失敗
                    tweetResult = @"投票できませんでした";
                    break;
                default:
                    break;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *tweetResultAlert =
            [[UIAlertView alloc] initWithTitle:tweetResult
                                       message:@""
                                      delegate:self
                             cancelButtonTitle:@"確認"
                             otherButtonTitles:nil];
            [tweetResultAlert show];
            
        }];
    }
      [inputPointData removeObjectForKey:@"INPUT_POINT"];
}



@end
