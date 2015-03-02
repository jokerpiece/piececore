//
//  CheckinViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/07.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CheckinViewController.h"

@interface CheckinViewController ()

@end

@implementation CheckinViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"CheckinViewController" owner:self options:nil];
}

-(void)viewdidLoadLogic{
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self syncAction];
    [self setTestData];
    self.map.delegate = self;
    self.map.showsUserLocation = YES;
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    // Return the number of rows in the section.
//    if (section == 0) {
//        return 1;
//    } else{
        return self.data.list.count;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Configure the cell...
//    if (indexPath.section == 0) {
//        static NSString *CellIdentifier = @"Cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake( 0, 0, 320, 40 );
//            [[btn layer]setCornerRadius:15.0f];
//            [btn setClipsToBounds:YES];
//            btn.backgroundColor = [UIColor grayColor];
//            btn.tintColor = [UIColor whiteColor];
//            [btn setTitle:@"チェックイン" forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside ];
//            [cell.contentView addSubview:btn];
//        }
//        return cell;
//        } else {
            NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            //if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            SpotData *model = [self.data.list objectAtIndex:indexPath.row];
            
            
            UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,20,300,40)];
            textLbl.text = model.shopName;
            textLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
            textLbl.alpha = 1.0f;
            textLbl.backgroundColor = [UIColor clearColor];
            textLbl.numberOfLines = 2;
            [cell.contentView addSubview:textLbl];
            
            UILabel *addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,45,300,60)];
            addressLbl.text = model.address;
            addressLbl.font = [UIFont fontWithName:@"AppleGothic" size:13];
            addressLbl.alpha = 1.0f;
            addressLbl.numberOfLines = 2;
            addressLbl.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:addressLbl];
            
            UILabel *distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(180,20,300,40)];
            
            CLLocation *recordLocation = [[CLLocation alloc] initWithLatitude:model.lat.floatValue longitude:model.lon.floatValue];
            distanceLbl.text = [NSString stringWithFormat:@"あと%f m",[self.locationManager.location distanceFromLocation:recordLocation]];
            distanceLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
            distanceLbl.alpha = 1.0f;
            distanceLbl.backgroundColor = [UIColor clearColor];
            
            [cell.contentView addSubview:distanceLbl];
            //}
            return cell;
//        }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if(indexPath.section == 0){
//        return 40;
//    }
    
    return 93.0f;
}

#pragma mark - Table view delegate

/**
 * セルが選択されたとき
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotData *spot = [self.data.list objectAtIndex:indexPath.row];
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


-(void)setData:(BaseConnector *)data sendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdSpotList]) {
        self.data = (SpotConnector*)data;
        for (SpotData *model in self.data.list) {
            CustomAnnotation* pin = [[CustomAnnotation alloc] init];
            pin.coordinate = CLLocationCoordinate2DMake(model.lat.floatValue,model.lon.floatValue); // 緯度経度
            pin.title = model.shopName;//タイトル
            pin.subtitle = model.address;//サブタイトル
            [self.map addAnnotation:pin];
        }
        [self.table reloadData];
    } else if ([sendId isEqualToString:SendIdCheckin]){
        CeckinConnector *checkinData = (CeckinConnector *)data;
        GetPointView *getPointView = [[GetPointView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 300)/2, 500, 300, 300) point:checkinData.get_point];
        
        [self.view addSubview:getPointView];
        self.pointView = getPointView;
        //アニメーションの対象となるコンテキスト
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        //アニメーションを実行する時間
        [UIView setAnimationDuration:1.0];
        //アニメーションイベントを受け取るview
        [UIView setAnimationDelegate:self];
        
        
        [getPointView setFrame:CGRectMake((self.view.frame.size.width - 300)/2, (self.view.frame.size.height -300)/2, 300, 300)];
        
        // アニメーション開始
        [UIView commitAnimations];
    }
    
}

-(BaseConnector *)getDataWithSendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdSpotList]) {
        return [SpotConnector alloc];
    } else {
        return [CeckinConnector alloc];
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
    if (self.pointView != nil){
        return;
    }
//    GetPointView *getPointView = [[GetPointView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 300)/2, 500, 300, 300) point:@"+1"];
//    
//    [self.view addSubview:getPointView];
//    self.pointView = getPointView;
//    //アニメーションの対象となるコンテキスト
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    //アニメーションを実行する時間
//    [UIView setAnimationDuration:1.0];
//    //アニメーションイベントを受け取るview
//    [UIView setAnimationDelegate:self];
//    
//    
//    [getPointView setFrame:CGRectMake((self.view.frame.size.width - 300)/2, (self.view.frame.size.height -300)/2, 300, 300)];
//    
//    // アニメーション開始
//    [UIView commitAnimations];

    [self checkinAction:@"111"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.pointView == nil){
        return;
    }
//    UITouch *touch = [touches anyObject];
//    switch (touch.view.tag) {
            //アニメーションの対象となるコンテキスト
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:nil context:context];
            //アニメーションを実行する時間
            [UIView setAnimationDuration:1.0];
            //アニメーションイベントを受け取るview
            [UIView setAnimationDelegate:self];
            
            
            [self.pointView setFrame:CGRectMake((self.view.frame.size.width - 300)/2, 500, 300, 300)];
            //アニメーション終了後に実行される
            [UIView setAnimationDidStopSelector:@selector(endAnimation)];
            // アニメーション開始
            [UIView commitAnimations];
//    }
}
-(void)endAnimation{
    [self.pointView removeFromSuperview];
    self.pointView = nil;
    
}
-(void)setTestData{
    SpotData *spot1 = [[SpotData alloc]init];
    spot1.shopName = @"大阪本店";
    spot1.address = @"大阪市中央区城見2-1-61　ツイン21MIDタワー37F";
    spot1.lat = @"34.692732";
    spot1.lon = @"135.531462";
    self.data = [[SpotConnector alloc]init];
    self.data.list = [NSMutableArray array];
    [self.data.list addObject:spot1];
    
    SpotData *spot2 = [[SpotData alloc]init];
    spot2.shopName = @"幕張メッセ店";
    spot2.address = @"千葉県千葉市 美浜区中瀬2丁目1";
    spot2.lat = @"35.647244";
    spot2.lon = @"140.033701";
    [self.data.list addObject:spot2];
    
    [self.table reloadData];
}
@end
