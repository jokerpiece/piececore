//
//  PlayYoutubeViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/09.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import "PlayerView.h"
@interface PlayYoutubeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet PlayerView *playView2;
@property (weak, nonatomic) IBOutlet PlayerView *playView3;
@property (weak, nonatomic) IBOutlet PlayerView *playView4;
@property (nonatomic) AVPlayer *player;

@end
