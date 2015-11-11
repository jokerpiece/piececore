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

@end

@implementation PlayHologramYoutubeViewController

-(void)viewDidLoadLogic{
    float startY = 150;
    float sideSize = self.viewSize.width / 3;
    float insize = sideSize * 0.15;
    
    NSDictionary *dict = [HCYoutubeParser h264videosWithYoutubeID:self.youtubeId];
    NSURL *url = [NSURL URLWithString:dict[@"small"]];
    
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
    
    self.player = [[AVPlayer alloc]initWithURL:url];
    
    
    
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
    
    //[self presentViewController:vc animated:YES completion:nil];
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
    self.seekBar.maximumValue = CMTimeGetSeconds( self.player.currentItem.asset.duration );
    self.seekBar.value        = 0;
    [self.seekBar addTarget:self action:@selector(seekBarValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // 再生時間とシークバー位置を連動させるためのタイマー
    const double interval = ( 0.5f * self.seekBar.maximumValue ) / self.seekBar.bounds.size.width;
    const CMTime time     = CMTimeMakeWithSeconds( interval, NSEC_PER_SEC );
    self.playTimeObserver = [self.player addPeriodicTimeObserverForInterval:time
                                                                           queue:NULL
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

- (NSString* )timeToString:(float)value
{
    const NSInteger time = value;
    return [NSString stringWithFormat:@"%d:%02d", ( int )( time / 60 ), ( int )( time % 60 )];
}

@end
