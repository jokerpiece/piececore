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
@property (weak, nonatomic) IBOutlet PlayHologramView *playView;
@property (weak, nonatomic) IBOutlet PlayHologramView *playView2;
@property (weak, nonatomic) IBOutlet PlayHologramView *playView3;
@property (weak, nonatomic) IBOutlet PlayHologramView *playView4;
@property (nonatomic) AVPlayer *player;

@end
