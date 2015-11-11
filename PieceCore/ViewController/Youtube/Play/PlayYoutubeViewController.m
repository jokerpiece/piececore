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
@end

@implementation PlayYoutubeViewController

- (void)viewDidLoadLogic {
    
    NSDictionary *dict = [HCYoutubeParser h264videosWithYoutubeID:self.youtubeId];
    NSURL *url = [NSURL URLWithString:dict[@"small"]];
    
    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.view.frame = CGRectMake(0,0,320,480);
    moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    [moviePlayer play];
    
    // メンバとして保持する
    self.moviePlayerController = moviePlayer;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayerController];
}

- (void)moviePlayBackDidFinished:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    switch([[userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"playback ended");
            break;
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"playback error");
            break;
    }
}

@end
