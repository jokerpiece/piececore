//
//  MapViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/04/22.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"MapViewController" owner:self options:nil];
}

-(void)viewDidLoadLogic{
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self syncAction];
    //[self setTestData];
    self.map.delegate = self;
    self.map.showsUserLocation = YES;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    CLLocationCoordinate2D co;
    co.latitude = 35.68664111; // 経度
    co.longitude = 139.6948839; // 緯度
    [self.map setCenterCoordinate:co animated:NO];
    
    MKCoordinateRegion cr = self.map.region;
    cr.center = co;
    cr.span.latitudeDelta = 0.01;
    cr.span.longitudeDelta = 0.01;
    [self.map setRegion:cr animated:NO];
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        // 測位開始
        [self.locationManager startUpdatingLocation];
        [self.map setUserTrackingMode:MKUserTrackingModeFollow];
    } else {
        DLog(@"位置情報を使用できません");
    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake( 220, 10, 90, 30 );
    [[btn layer]setCornerRadius:15.0f];
    [btn setClipsToBounds:YES];
    btn.backgroundColor = [UIColor orangeColor];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitle:@"チェックイン" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [btn addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside ];
    
    [self.view addSubview:btn];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.spotRecipient.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    SpotData *data = [self.spotRecipient.list objectAtIndex:indexPath.row];
    
    
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,20,180,40)];
    textLbl.text = data.shopName;
    textLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
    textLbl.alpha = 1.0f;
    textLbl.backgroundColor = [UIColor clearColor];
    textLbl.numberOfLines = 2;
    [cell.contentView addSubview:textLbl];
    
    UILabel *addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,45,300,60)];
    addressLbl.text = data.address;
    addressLbl.font = [UIFont fontWithName:@"AppleGothic" size:13];
    addressLbl.alpha = 1.0f;
    addressLbl.numberOfLines = 2;
    addressLbl.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:addressLbl];
    
    UILabel *distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(220,20,300,40)];
    
    CLLocation *recordLocation = [[CLLocation alloc] initWithLatitude:data.lat.floatValue longitude:data.lon.floatValue];
    distanceLbl.text = [NSString stringWithFormat:@"あと%.0f m",[self.locationManager.location distanceFromLocation:recordLocation]];
    distanceLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
    distanceLbl.alpha = 1.0f;
    distanceLbl.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:distanceLbl];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotData *spot = [self.spotRecipient.list objectAtIndex:indexPath.row];
    CLLocationCoordinate2D co;
    co.latitude = spot.lat.floatValue; // 経度
    co.longitude = spot.lon.floatValue; // 緯度
    [self.map setCenterCoordinate:co animated:YES];
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [conecter sendActionSendId:SendIdSpotList param:param];
    
}

-(void)checkinAction:(NSString *)shopId{
    self.isResponse = NO;
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [param setValue:shopId forKey:@"shop_id"];
    
    [conecter sendActionSendId:SendIdCheckin param:param];
    
}


-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdSpotList]) {
        self.spotRecipient = (SpotRecipient*)recipient;
        for (SpotData *data in self.spotRecipient.list) {
            CustomAnnotation* pin = [[CustomAnnotation alloc] init];
            pin.coordinate = CLLocationCoordinate2DMake(data.lat.floatValue,data.lon.floatValue); // 緯度経度
            pin.title = data.shopName;//タイトル
            pin.subtitle = data.address;//サブタイトル
            [self.map addAnnotation:pin];
        }
        [self.table reloadData];
    } else if ([sendId isEqualToString:SendIdCheckin]){
        CeckinRecipient *checkinRecipient = (CeckinRecipient *)recipient;
        GetPointView *getPointView = [[GetPointView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 300)/2, 500, 300, 300) point:checkinRecipient.get_point];
        
        [self.view addSubview:getPointView];
        self.checkinPointView = getPointView;
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        
        
        [getPointView setFrame:CGRectMake((self.view.frame.size.width - 300)/2, (self.view.frame.size.height -300)/2, 300, 300)];
        [UIView commitAnimations];
    }
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdSpotList]) {
        return [SpotRecipient alloc];
    } else {
        return [CeckinRecipient alloc];
    }
    
}

#pragma mark - CLLocationManagerDelegate
// 位置情報更新時
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [self.table reloadData];
}

- ( void )onTapButton:( id )sender
{
    if (self.checkinPointView != nil){
        return;
    }
    [self checkinAction:@"111"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.checkinPointView == nil){
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    
    [self.checkinPointView setFrame:CGRectMake((self.view.frame.size.width - 300)/2, 500, 300, 300)];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    [UIView commitAnimations];
}
-(void)endAnimation{
    [self.checkinPointView removeFromSuperview];
    self.checkinPointView = nil;
    
}
-(void)setTestData{
    SpotData *spot1 = [[SpotData alloc]init];
    spot1.shopName = @"大阪本店";
    spot1.address = @"大阪市中央区城見2-1-61　ツイン21MIDタワー37F";
    spot1.lat = @"34.692732";
    spot1.lon = @"135.531462";
    self.spotRecipient = [[SpotRecipient alloc]init];
    self.spotRecipient.list = [NSMutableArray array];
    [self.spotRecipient.list addObject:spot1];
    
    SpotData *spot2 = [[SpotData alloc]init];
    spot2.shopName = @"幕張メッセ店";
    spot2.address = @"千葉県千葉市 美浜区中瀬2丁目1";
    spot2.lat = @"35.647244";
    spot2.lon = @"140.033701";
    [self.spotRecipient.list addObject:spot2];
    
    SpotData *spot3 = [[SpotData alloc]init];
    spot3.shopName = @"幕張メッセ店";
    spot3.address = @"千葉県千葉市 美浜区中瀬2丁目1";
    spot3.lat = @"35.647244";
    spot3.lon = @"140.033701";
    [self.spotRecipient.list addObject:spot3];
    
    SpotData *spot4 = [[SpotData alloc]init];
    spot4.shopName = @"幕張メッセ店";
    spot4.address = @"千葉県千葉市 美浜区中瀬2丁目1";
    spot4.lat = @"35.647244";
    spot4.lon = @"140.033701";
    [self.spotRecipient.list addObject:spot4];
    
    SpotData *spot5 = [[SpotData alloc]init];
    spot5.shopName = @"幕張メッセ店";
    spot5.address = @"千葉県千葉市 美浜区中瀬2丁目1";
    spot5.lat = @"35.647244";
    spot5.lon = @"140.033701";
    [self.spotRecipient.list addObject:spot5];
    
    SpotData *spot6 = [[SpotData alloc]init];
    spot6.shopName = @"幕張メッセ店";
    spot6.address = @"千葉県千葉市 美浜区中瀬2丁目1";
    spot6.lat = @"35.647244";
    spot6.lon = @"140.033701";
    [self.spotRecipient.list addObject:spot6];
    
    for (SpotData *data in self.spotRecipient.list) {
        CustomAnnotation* pin = [[CustomAnnotation alloc] init];
        pin.coordinate = CLLocationCoordinate2DMake(data.lat.floatValue,data.lon.floatValue); // 緯度経度
        pin.title = data.shopName;//タイトル
        pin.subtitle = data.address;//サブタイトル
        [self.map addAnnotation:pin];
    }
    [self.table reloadData];
}
@end
