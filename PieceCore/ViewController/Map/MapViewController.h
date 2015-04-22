//
//  MapViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/04/22.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import "MapCell.h"
#import "SpotRecipient.h"
#import "CustomAnnotation.h"
#import <MapKit/MapKit.h>
#import "GetPointView.h"
#import "CeckinRecipient.h"

@interface MapViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) SpotRecipient *spotRecipient;
@property (strong, nonatomic) GetPointView *checkinPointView;
@end
