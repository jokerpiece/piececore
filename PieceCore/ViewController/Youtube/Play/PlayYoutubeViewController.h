//
//  PlayYoutubeViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface PlayYoutubeViewController : BaseViewController
@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;
@property (nonatomic) NSString *youtubeId;

@end
