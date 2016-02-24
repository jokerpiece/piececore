//
//  PlayYoutubeViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/09.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "PlayHologramYoutubeViewController.h"
#import "HCYoutubeParser.h"
#import <MediaPlayer/MediaPlayer.h>


@interface PlayHologramYoutubeViewController ()
@property (nonatomic) NSURL *url;
@end

@implementation PlayHologramYoutubeViewController


-(void)viewDidLoadLogic{
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view_Tapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    
    //[self presentViewController:vc animated:YES completion:nil];
}

-(void)getMovieURLWithUrl:(NSURL *)url{
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        DLog(@"Documents directory not found!");
    }
    NSString *appFile = [self getAppFile];
    
    
    if ([fileMgr fileExistsAtPath:appFile]) {   // ローカルに動画が存在する時
        self.url = [NSURL fileURLWithPath:appFile];
        
       
    }else{
        
        self.url = url;
    }
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
            [movieDic setValue:@"2" forKey:@"TYPE"];
            
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

-(void)setPlayViews{
    
    float startY = self.viewSize.width * 0.26;
    float sideSize = self.viewSize.width / 3;
    float insize = sideSize * 0.15;
    
    NSDictionary *dict = [HCYoutubeParser h264videosWithYoutubeID:self.youtubeId];
    NSURL *url = [NSURL URLWithString:dict[@"small"]];
    
    [self getMovieURLWithUrl:url];
    //上
    self.playView1 = [[PlayHologramView alloc]initWithFrame:CGRectMake(sideSize, startY + insize, sideSize, sideSize)];
    
    CGFloat angle1 = 270.0 * M_PI / 180.0;
    //左
    self.playView2 = [[PlayHologramView alloc]initWithFrame:CGRectMake(0 + insize, startY + sideSize, sideSize, sideSize)];
    self.playView2.transform = CGAffineTransformMakeRotation(angle1);
    //self.playView2.backgroundColor = [UIColor orangeColor];
    
    CGFloat angle2 = 90.0 * M_PI / 180.0;
    //右
    self.playView3 = [[PlayHologramView alloc]initWithFrame:CGRectMake(sideSize * 2 - insize, startY + sideSize , sideSize, sideSize)];
    self.playView3.transform = CGAffineTransformMakeRotation(angle2);
    //self.playView3.backgroundColor = [UIColor blueColor];
    
    CGFloat angle3 = 180.0 * M_PI / 180.0;
    //下
    self.playView4 = [[PlayHologramView alloc]initWithFrame:CGRectMake(sideSize, startY + sideSize *2 -insize, sideSize, sideSize)];
    self.playView4.transform = CGAffineTransformMakeRotation(angle3);
    
    self.player = [[AVPlayer alloc]initWithURL:self.url];
    
    
    
    [(AVPlayerLayer*)self.playView1.layer setPlayer:self.player];
    [(AVPlayerLayer*)self.playView2.layer setPlayer:self.player];
    [(AVPlayerLayer*)self.playView3.layer setPlayer:self.player];
    [(AVPlayerLayer*)self.playView4.layer setPlayer:self.player];
    
    [self.view addSubview:self.playView1];
    [self.view addSubview:self.playView2];
    [self.view addSubview:self.playView3];
    [self.view addSubview:self.playView4];
    [self.player addObserver:self
                  forKeyPath:@"status"
                     options:NSKeyValueObservingOptionNew
                     context:(__bridge void * _Nullable)(self.player)];
    
    // 終了通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerDidPlayToEndTime:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player];
    
    
   [self setupSeekBar];
}
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    //再生準備が整い次第、動画を再生させる。
    if([self.player status] == AVPlayerItemStatusReadyToPlay){
        
        [self.player removeObserver:self forKeyPath:@"status"];
        
        [self.player play];
        
        return;
    }
    
    [super observeValueForKeyPath:keyPath
                         ofObject:object
                           change:change
                          context:context];
}


- (void) playerDidPlayToEndTime:(NSNotification*)notfication
{
    
    if (self.player)
    {
        
            //リピート再生
            [self.player seekToTime:kCMTimeZero];
            [self.player play];
        
    }
}

- (void)setupSeekBar
{
    self.seekBar.minimumValue = 0;
    float maxValue = CMTimeGetSeconds( self.player.currentItem.asset.duration );
    
    self.seekBar.maximumValue = maxValue;
    self.seekBar.value        = 0;
    [self.seekBar addTarget:self action:@selector(seekBarValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // 再生時間とシークバー位置を連動させるためのタイマー
    const double interval = ( 0.5f * self.seekBar.maximumValue ) / self.seekBar.bounds.size.width;
    const CMTime time     = CMTimeMakeWithSeconds( interval, NSEC_PER_SEC );
    self.playTimeObserver = [self.player addPeriodicTimeObserverForInterval:time
                                                                           queue:nil
                                                                      usingBlock:^( CMTime time ) { [self syncSeekBar]; }];
    
    self.durationLabel.text = [self timeToString:self.seekBar.maximumValue];
}

- (void)syncSeekBar
{
    const double duration = CMTimeGetSeconds( [self.player.currentItem duration] );
    const double time     = CMTimeGetSeconds([self.player currentTime]);
    const float  value    = ( self.seekBar.maximumValue - self.seekBar.minimumValue ) * time / duration + self.seekBar.minimumValue;
    
    [self.seekBar setValue:value];
    self.currentTimeLabel.text = [self timeToString:self.seekBar.value];
}

- (void)seekBarValueChanged:(UISlider *)slider
{
    [self.player seekToTime:CMTimeMakeWithSeconds( slider.value, NSEC_PER_SEC )];
    [self.player play];
}

- (void)view_Tapped:(UITapGestureRecognizer *)sender
{
    [self.previewIv removeFromSuperview];
    [self setPlayViews];
    
}

- (NSString* )timeToString:(float)value
{
    const NSInteger time = value;
    return [NSString stringWithFormat:@"%d:%02d", ( int )( time / 60 ), ( int )( time % 60 )];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
//        [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
        ;
    }];
}

- (IBAction)downloadAction:(id)sender {
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
