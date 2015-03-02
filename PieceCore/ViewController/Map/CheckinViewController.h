//
//  CheckinViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/07.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BaseViewController.h"
#import "MapCell.h"
#import "SpotConnector.h"
#import "CustomAnnotation.h"
#import <MapKit/MapKit.h>
#import "GetPointView.h"
#import "CeckinConnector.h"


@interface CheckinViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) SpotConnector *data;
@property (strong, nonatomic) GetPointView *pointView;
@end
