//
//  GpsSearchViewController.h
//  pieceSample
//
//  Created by mikata on 2015/11/20.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface GpsSearchViewController : BaseViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic) NSString *takeOrderId;
@property (nonatomic) NSString *takeType;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)closeActionBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *closeAction;

- (IBAction)locationCurrentBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *locationCurrent;

- (IBAction)locationOtherBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *locationOther;
@end
