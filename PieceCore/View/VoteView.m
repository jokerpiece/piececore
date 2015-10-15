//
//  VoteView.m
//  pieceSample
//
//  Created by ハマモト  on 2015/10/15.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "VoteView.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>
@implementation VoteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // make self from nib file
        UINib *nib = [UINib nibWithNibName:@"VoteView" bundle:nil];
        self = [nib instantiateWithOwner:nil options:nil][0];
    }
    return self;
}

- (IBAction)voteAction:(id)sender {
    
    //Point入力判定
    if(self.inputPointTf.text.intValue > self.userPoint.intValue){
        //アラート表示
        UIAlertView *pointOverAlert =
        [[UIAlertView alloc] initWithTitle:@"エラー"
                                   message:@"保持しているPoint以上の値が入力されました。"
                                  delegate:self
                         cancelButtonTitle:@"確認"
                         otherButtonTitles:nil];
        [pointOverAlert show];
    }else if (self.inputPointTf.text == 0){
        //アラート表示
        UIAlertView *pointEnptyAlert =
        [[UIAlertView alloc] initWithTitle:@"エラー"
                                   message:@"Pointを入力してください"
                                  delegate:self
                         cancelButtonTitle:@"確認"
                         otherButtonTitles:nil];
        [pointEnptyAlert show];
        
        
    }else{
        NSString *tweetAcountAdd = [self.twitterScrennId stringByAppendingString:@" "];
        SLComposeViewController *vc = [SLComposeViewController
                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
        [vc setInitialText:NSLocalizedString(tweetAcountAdd, nil)];
        [self.parnentVc presentViewController:vc animated:YES completion:nil];
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
            [self.parnentVc dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *tweetResultAlert =
            [[UIAlertView alloc] initWithTitle:tweetResult
                                       message:@""
                                      delegate:self
                             cancelButtonTitle:@"確認"
                             otherButtonTitles:nil];
            [tweetResultAlert show];
            
        }];
    }

}
@end
