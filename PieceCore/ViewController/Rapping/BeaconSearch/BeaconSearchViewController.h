//
//  BeaconSearchViewController.h
//  pieceSample
//
//  Created by mikata on 2015/11/18.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"

@interface BeaconSearchViewController : BaseViewController
@property (nonatomic) NSString *uuid;
@property (nonatomic) NSString *major;
@property (nonatomic) NSString *minor;
@property (weak, nonatomic) IBOutlet UIButton *treasureOk;
- (IBAction)treasureOkBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@end
