//
//  BeaconViewController.h
//  SmartConcierge
//
//  Created by mikata on 2015/03/17.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface Beacon : NSObject <CLLocationManagerDelegate>
- (id) initWithBeaconInfo:(NSString*)uuid
                    major:(NSString*)major
                    minor:(NSString*)minor;
-(void) startBeaconMonitoring;
-(void) stopBeaconMonitoring;
-(CLBeacon *)getBeaconInfo;
@end
