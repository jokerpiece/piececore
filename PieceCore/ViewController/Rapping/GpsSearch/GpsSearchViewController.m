//
//  GpsSearchViewController.m
//  pieceSample
//
//  Created by mikata on 2015/11/20.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "GpsSearchViewController.h"
#import "CoreDelegate.h"
#import "CustomAnnotationImage.h"

@interface GpsSearchViewController ()
{
    CLLocationManager *locationManager;
    NSTimer *timer;
    NSInteger firstFlg;
    NSString *strOrderId;
    NSString *strLatitude;
    NSString *strLongitude;

    NSString *otherLatitude;
    NSString *otherLongitude;
    NSString *otherUpdated;
    NSArray *mapLogos;
    
    CLLocationCoordinate2D locationCurrentCoordinate2D;
    CLLocationCoordinate2D locationOtherCoordinate2D;

    CustomAnnotationImage *viewAnnotation;
}
@property (nonatomic, retain) CLLocationManager *locationManager;
@end

@implementation GpsSearchViewController
@synthesize locationManager;

- (void)viewDidLoadLogic {
    self.closeAction.hidden = false;
    strOrderId = [self.takeOrderId substringToIndex:[self.takeOrderId length] - 1];
    strOrderId = [NSString stringWithFormat:@"%d", [strOrderId intValue]];

    // 位置情報サービス初期化
    locationManager = [[CLLocationManager alloc] init];
    // 位置情報サービスが利用できるかどうかをチェック
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self;

        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            // iOS バージョンが 8 以上
            [self.locationManager requestAlwaysAuthorization];
        } else {
            // iOS バージョンが 8 未満
            [self.locationManager startUpdatingLocation];
        }

        // mapViewのdelegate
        self.mapView.delegate = self;
        // 現在地表示
        [self.mapView setShowsUserLocation:YES];
        // ユーザーの現在位置に応じてマップを更新する
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        // 相手のアノテーション設定用
        mapLogos = [[NSArray alloc] init];
        // ボタン非表示
        self.locationOther.hidden = true;
        // 位置情報取得API
        firstFlg = 0;
        // 相手の現在地取得処理
        if (![timer isValid]) {
            timer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                     target:self
                                                   selector:@selector(loopTimer:)
                                                   userInfo:nil
                                                    repeats:YES];
        }
    } else {
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [locationManager stopUpdatingLocation];
    if ([timer isValid]) {
        [timer invalidate];
    }
}

- (IBAction)closeActionBtn:(UIButton *)sender {
    if ([timer isValid]) {
        [timer invalidate];
    }
    [self dismissViewControllerAnimated:NO completion:^{
        //        [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
        ;
    }];
}

#pragma mark - Location

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currentLocation = locations.lastObject;
    CLLocationDegrees latitude = currentLocation.coordinate.latitude;
    CLLocationDegrees longitude = currentLocation.coordinate.longitude;
    
    // 自分の緯度経度を設定
    locationCurrentCoordinate2D.latitude = latitude;
    locationCurrentCoordinate2D.longitude = longitude;
    // 自分の緯度経度を設定（送信用）
    strLatitude = [NSString stringWithFormat:@"%f", latitude];
    strLongitude = [NSString stringWithFormat:@"%f", longitude];
    
    if (firstFlg == 0) {
        firstFlg = 1;
        [self sendGetLocationData];
    }
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    } else {
        if ([timer isValid]) {
            [timer invalidate];
        }
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"位置情報利用不可" message:@"位置情報サービスから許可を設定して下さい。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (void)loopTimer:(NSTimer*)timer{
    // 位置情報取得API
    [self sendGetLocationData];
}

-(void)sendGetLocationData{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKeyPath:@"uuid"];
    [param setValue:strOrderId forKey:@"order_id"];
    [param setValue:strLatitude forKey:@"lat"];
    [param setValue:strLongitude forKey:@"long"];
    [param setValue:self.takeType forKey:@"type"];
    [conecter sendActionSendId:SendIdGetLocation param:param];
}

-(void)receiveSucceed:(NSDictionary *)receivedData sendId:(NSString *)sendId{
    BaseRecipient *recipient = [[BaseRecipient alloc] initWithResponseData:receivedData];
    if (recipient.error_code.intValue != 0) {
        return;
    }
    if (recipient.error_message.length > 0) {
        DLog(@"%@",recipient.error_message);
    }
    [self setDataWithRecipient:recipient sendId:sendId];
}

-(void)receiveError:(NSError *)error sendId:(NSString *)sendId{
    CoreDelegate *delegate = (CoreDelegate *)[[UIApplication sharedApplication] delegate];
    if (!delegate.isUpdate) {
        NSString *errMsg;
        switch (error.code) {
            case NSURLErrorBadServerResponse:
                errMsg = @"現在メンテナンス中です。\n大変申し訳ありませんがしばらくお待ち下さい。";
                break;
            case NSURLErrorTimedOut:
                errMsg = @"通信が混み合っています。\nしばらくしてからアクセスして下さい。";
                break;
                
            case kCFURLErrorNotConnectedToInternet:
                errMsg = @"通信できませんでした。\n電波状態をお確かめ下さい。";
                break;
            default:
                errMsg = [NSString stringWithFormat:@"エラーコード：%ld",(long)error.code];
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:errMsg
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    if ([recipient.resultset[@"status_code"] isEqualToString:@"00"]) {
        otherLatitude = recipient.resultset[@"lat"];
        otherLongitude = recipient.resultset[@"long"];
        otherUpdated = recipient.resultset[@"updated"];

        // 以前の足跡を削除
        [self.mapView removeAnnotations: mapLogos];

        // 相手の緯度経度を設定
        double latitude = [otherLatitude doubleValue];
        double longitude = [otherLongitude doubleValue];
        locationOtherCoordinate2D.latitude = latitude;
        locationOtherCoordinate2D.longitude = longitude;

        // 他人の場所を設定
        mapLogos = [[NSArray alloc] init];
        CustomAnnotationImage *annotation = [[CustomAnnotationImage alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        annotation.title = otherUpdated;
        annotation.imagePath = @"footprints.png";
        mapLogos = [mapLogos arrayByAddingObject:annotation];
        
        // バルーンとコールアウトを設定
        [self.mapView addAnnotations: mapLogos];
        
        // 地図設定
        [self.view addSubview:self.mapView];
        // ボタン設定
        if (![otherUpdated isEqualToString:@""]) {
            self.locationOther.hidden = false;
            [self.view addSubview:self.locationCurrent];
        }
        [self.view addSubview:self.locationOther];
    }
}

-(MKAnnotationView*)mapView:(MKMapView*)_mapView viewForAnnotation:(id )annotation {
    // 現在地表示なら nil を返す
    if([annotation isKindOfClass:[MKUserLocation class]]){
        ((MKUserLocation *)annotation).title = nil;
        return nil;
    }
    
    CustomAnnotationImage *customAnnotation = annotation;
    MKAnnotationView *annotationView;
    NSString* identifier = @"other";
    annotationView = (MKAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(nil == annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }

    //指定画像をリサイズ
    UIImage *image = [UIImage imageNamed:customAnnotation.imagePath];
    CGFloat width = 60;  // リサイズ後幅のサイズ
    CGFloat height = 60;  // リサイズ後高さのサイズ
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0, 0, width, height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    annotationView.image = image;
    annotationView.canShowCallout = YES;

    annotationView.annotation = annotation;
    viewAnnotation =annotation;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    [self.mapView selectAnnotation:viewAnnotation animated:NO];
}

- (IBAction)locationCurrentBtn:(UIButton *)sender {
    [self.mapView setCenterCoordinate:locationCurrentCoordinate2D animated:NO];
}

- (IBAction)locationOtherBtn:(UIButton *)sender {
    [self.mapView setCenterCoordinate:locationOtherCoordinate2D animated:NO];
}

@end
