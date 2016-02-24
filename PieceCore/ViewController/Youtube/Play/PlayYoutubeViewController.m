//
//  PlayYoutubeViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "PlayYoutubeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HCYoutubeParser.h"

@interface PlayYoutubeViewController ()
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (nonatomic) NSURL *url;
@end

@implementation PlayYoutubeViewController

- (void)viewDidAppearLogic {
    
    NSDictionary *dict = [HCYoutubeParser h264videosWithYoutubeID:self.youtubeId];
    NSURL *url = [NSURL URLWithString:dict[@"small"]];
    [self saveMovieWithUrl:url];
}

-(void)saveMovieWithUrl:(NSURL *)url{
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    
    NSString *appFile = [self getAppFile];
    
    
    if ([fileMgr fileExistsAtPath:appFile]) {   // ローカルに動画が存在する時
        self.url = [NSURL fileURLWithPath:appFile];
    }else{
        self.url =url;
    }
    
    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.view.frame = CGRectMake(0,0,self.viewSize.width,self.viewSize.height);
    moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    [moviePlayer play];
    
    UIImage *img = [UIImage imageNamed:@"download.png"];  // ボタンにする画像を生成する
    UIButton *btn = [[UIButton alloc]
                     initWithFrame:CGRectMake(16, 22, 33, 36)];  // ボタンのサイズを指定する
    [btn setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にhogeメソッドを呼び出す
    [btn addTarget:self
            action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    UIImage *img2 = [UIImage imageNamed:@"btn_close.png"];  // ボタンにする画像を生成する
    UIButton *btn2 = [[UIButton alloc]
                     initWithFrame:CGRectMake(self.view.frame.size.width - 50, 33, 25, 25)];  // ボタンのサイズを指定する
    [btn2 setBackgroundImage:img2 forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にhogeメソッドを呼び出す
    [btn2 addTarget:self
            action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    // メンバとして保持する
    self.moviePlayerController = moviePlayer;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayerController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:self.moviePlayerController];

}
-(NSString *)getAppFile{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        DLog(@"Documents directory not found!");
    }
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",self.youtubeId]];
}
-(void)saveMovie
{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *StTime = [format stringFromDate:[NSDate date]];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    
    NSData *moveListData = [[NSUserDefaults standardUserDefaults] objectForKey:@"MOVE_LIST"];
    NSMutableArray *movieList;
    if (moveListData) {
        movieList = [NSKeyedUnarchiver unarchiveObjectWithData:moveListData];
    }

    if (movieList.count == 0) {
        movieList = [NSMutableArray array];
    }

    for (NSMutableDictionary *dc in movieList) {
        if ([[dc valueForKey:@"YOUTUBEID"]isEqualToString:self.youtubeId]) {
            [self showAlert:@"確認" message:@"すでにダウンロードされている動画です。"];
            return;
        }
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.url) {
            NSData *imageData;
            imageData = [NSData dataWithContentsOfURL:self.url];
            [imageData writeToFile:[self getAppFile] atomically:YES];
            
            NSMutableDictionary* movieDic = [NSMutableDictionary dictionary];
            [movieDic setObject:self.youtubeId forKey:@"YOUTUBEID"];
            [movieDic setValue:StTime forKey:@"DATE"];
            [movieDic setValue:@"1" forKey:@"TYPE"];
            
            [movieList addObject:movieDic];
            
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:movieList];
            [ud setObject:data forKey:@"MOVE_LIST"];
            
            [ud synchronize];
            UIAlertView *alert =
            [[UIAlertView alloc]
             initWithTitle:@"確認"
             message:@"ダウンロードが完了しました。"
             delegate:nil
             cancelButtonTitle:nil
             otherButtonTitles:@"はい", nil
             ];
            [alert show];
        }
        
    });
    
}

- (void)moviePlayBackDidFinished:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    switch([[userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            DLog(@"playback ended");
            
            break;
        case MPMovieFinishReasonPlaybackError:
            DLog(@"playback error");
            [self dismissViewControllerAnimated:NO completion:^{
                //        [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
                ;
            }];
    }
}

-(void)doneButtonClick:(NSNotification*)notification{
    [self dismissViewControllerAnimated:NO completion:^{
        //        [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
        ;
    }];
}

- (void)downloadAction:(id)sender {
    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:@"確認"
     message:@"ダウンロードには時間がかかる場合があります。\nダウンロードをしますか？"
     delegate:self
     cancelButtonTitle:@"いいえ"
     otherButtonTitles:@"はい", nil
     ];
    [alert show];
    alert.tag = 1;
}

- (void)closeAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        //        [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
        ;
    }];

}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            if (alertView.tag == 1) {
                [self saveMovie];
            }
            break;
    }
    
}
@end
