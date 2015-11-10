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
    NSDictionary *dict = [HCYoutubeParser h264videosWithYoutubeID:@"JGlU4r3P3I0"];
    NSURL *url = [NSURL URLWithString:dict[@"medium"]];
    
    CGFloat angle1 = 45.0 * M_PI / 180.0;
    self.playView2.transform = CGAffineTransformMakeRotation(angle1);
    
    CGFloat angle2 = 90.0 * M_PI / 180.0;
    self.playView3.transform = CGAffineTransformMakeRotation(angle2);
    
    CGFloat angle3 = 135.0 * M_PI / 180.0;
    self.playView4.transform = CGAffineTransformMakeRotation(angle3);
    
   self.player = [[AVPlayer alloc]initWithURL:url];
    [(AVPlayerLayer*)self.playView.layer setPlayer:self.player];
    [(AVPlayerLayer*)self.playView2.layer setPlayer:self.player];
    [(AVPlayerLayer*)self.playView3.layer setPlayer:self.player];
    [(AVPlayerLayer*)self.playView4.layer setPlayer:self.player];
    
    [self.player addObserver:self
             forKeyPath:@"status"
                options:NSKeyValueObservingOptionNew
                context:(__bridge void * _Nullable)(self.player)];
    
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
@end
