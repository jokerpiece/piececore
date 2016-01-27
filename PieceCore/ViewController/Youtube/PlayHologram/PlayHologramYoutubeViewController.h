//
//  PlayYoutubeViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/09.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import "PlayHologramView.h"
@interface PlayHologramYoutubeViewController : BaseViewController
@property (nonatomic) PlayHologramView *playView1;
@property (nonatomic) PlayHologramView *playView2;
@property (nonatomic) PlayHologramView *playView3;
@property (nonatomic) PlayHologramView *playView4;
@property (weak, nonatomic) IBOutlet UIImageView *previewIv;
@property (nonatomic) NSString *youtubeId;
@property (nonatomic) AVPlayer *player;
//@property (nonatomic) AVPlayerItem *playerItem;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (nonatomic, assign) id playTimeObserver;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *seekBar;
- (IBAction)closeAction:(id)sender;
- (IBAction)downloadAction:(id)sender;

@end
