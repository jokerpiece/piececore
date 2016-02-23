//
//  BeaconSearchViewController.m
//  pieceSample
//
//  Created by mikata on 2015/11/18.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BeaconSearchViewController.h"
#import "Beacon.h"

@interface BeaconSearchViewController ()
{
    Beacon  *beacon;
    NSTimer *timer;
}
@end

@implementation BeaconSearchViewController

- (void)viewDidLoadLogic {
    self.uuid   = _uuid;
    self.major  = _major;
    self.minor  = _minor;
    
    self.img.image = [UIImage imageNamed:@"treasure5.png"];
    
    beacon = [[Beacon alloc] initWithBeaconInfo:self.uuid major:self.major minor:self.minor];
    [beacon startBeaconMonitoring];

    if (![timer isValid]) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(loopTimer:)
                                               userInfo:nil
                                                repeats:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [beacon stopBeaconMonitoring];
    if ([timer isValid]) {
        [timer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loopTimer:(NSTimer*)timer
{
    // 現在のビーコン情報取得
    CLBeacon *beacon_info = [beacon getBeaconInfo];
    NSInteger rssi = beacon_info.rssi;
    rssi = rssi * -1;

    // アドバタイズしているビーコンまでの距離に関する情報
    if (0 == rssi) {
        self.img.image = [UIImage imageNamed:@"treasure5.png"];
    } else if (60 >= rssi) {
        self.img.image = [UIImage imageNamed:@"treasure1.png"];
    } else if (70 >= rssi) {
        self.img.image = [UIImage imageNamed:@"treasure2.png"];
    } else if (85 >= rssi) {
        self.img.image = [UIImage imageNamed:@"treasure3.png"];
    } else if (100 >= rssi) {
        self.img.image = [UIImage imageNamed:@"treasure4.png"];
    } else if (100 < rssi) {
        self.img.image = [UIImage imageNamed:@"treasure5.png"];
    }
}

- (IBAction)treasureOkBtn:(UIButton *)sender {
    [beacon stopBeaconMonitoring];
    if ([timer isValid]) {
        [timer invalidate];
    }

    [self dismissViewControllerAnimated:NO completion:^{
        //        [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
        ;
    }];
}
@end
