//
//  Beacon.m
//
//  Created by mikata on 2015/03/16.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "Beacon.h"

@interface Beacon ()
{
    // 現在のビーコン情報
    CLBeacon    *objectBeacon;
}

@property (strong, nonatomic) NSString          *detectionUuid;
@property (strong, nonatomic) NSNumber          *detectionMajor;
@property (strong, nonatomic) NSNumber          *detectionMinor;

@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLBeaconRegion    *region;
@property (strong, nonatomic) NSUUID            *proximityUUID;
@property (strong, nonatomic) NSString          *identifier;
@end

@implementation Beacon

- (id) initWithBeaconInfo:(NSString*)uuid major:(NSString*)major minor:(NSString*)minor {
    if (self = [super init]) {
        self.identifier = @"identifier";
        self.detectionUuid = uuid;
        self.detectionMajor = [NSNumber numberWithInt:[major intValue]];
        self.detectionMinor = [NSNumber numberWithInt:[minor intValue]];
    }
    return self;
}

#pragma mark CLLocationManagerDelegate

/*
 * 領域観測が正常に開始されると呼ばれる
 */
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.manager requestStateForRegion:self.region];
}

/*
 * 領域に入ると呼ばれる
 */
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    [self startBeaconMonitoring];
    [self sendNotification:@"start"];
}

/*
 * 領域から出ると呼ばれる
 */
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    // Background Task を実行
    [self runBackgroundTask];
    [self sendNotification:@"end"];
}

/*
 * Background Task を実行する
 */
-(void)runBackgroundTask
{
    UIApplication *application = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // 既に実行済みであれば終了する
            if (bgTask != UIBackgroundTaskInvalid) {
                [application endBackgroundTask:bgTask];
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self stopBeaconMonitoring];
    });
}

/*
 * 領域内でビーコンを受信する度に呼ばれる（実機で確認する限りでは約1秒毎）
 * ビーコンの状態が変わった時も呼ばれる
 */
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    // 初期化
    NSString *uuid                          = @"unknown";
    CLProximity proximity                   = CLProximityUnknown;
    CLLocationAccuracy accuracy             = 0.0;
    NSInteger rssi                          = 0;
    NSNumber *major                         = @0;
    NSNumber *minor                         = @0;
    
    // 同一uuidが近くにある場合、それに反応する可能性があるのでwaitCountを設定する
    if ([beacons count] > 0) {
        // 最も近くにあるビーコンが配列の先頭にあるように、デバイスからの距離によって整列されている
        NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"proximity != %d", CLProximityUnknown];
        NSArray *validBeacons   = [beacons filteredArrayUsingPredicate:predicate];
        
        CLBeacon *beacon    = validBeacons.firstObject;
        uuid                = beacon.proximityUUID.UUIDString;
        proximity           = beacon.proximity;
        accuracy            = beacon.accuracy;
        rssi                = beacon.rssi;
        major               = beacon.major;
        minor               = beacon.minor;

        // アドバタイズしているビーコンの強度に関する情報
        // ビーコン検知は不安定なので、最も強い強度のビーコンが常に取得できない
        // そのため、countNear秒間、最も強い強度のビーコンとして検知し続けなければ別のビーコン情報に変更はしない
        if ([self.detectionUuid isEqualToString:uuid]
            && [self.detectionMajor isEqualToNumber:major]
            && [self.detectionMinor isEqualToNumber:minor]) {
            // 同じビーコンなのでビーコン情報を設定
            objectBeacon = beacon;
        }
    }
    return;
}

/*
 * ビーコン監視 スタート
 */
-(void) startBeaconMonitoring
{
    // Create Manager
    self.manager            = [CLLocationManager new];
    [self.manager requestAlwaysAuthorization];
    self.manager.delegate   = self;

    {
        uint16_t uintMajor = (uint16_t)[self.detectionMajor  integerValue];
        uint16_t uintMinor = (uint16_t)[self.detectionMinor  integerValue];
        self.proximityUUID      = [[NSUUID alloc]initWithUUIDString:self.detectionUuid];
        self.region = [[CLBeaconRegion alloc]initWithProximityUUID:self.proximityUUID
                                                             major:uintMajor
                                                             minor:uintMinor
                                                        identifier:self.identifier];
        // いずれもデフォルト設定値
        self.region.notifyOnEntry               = YES;
        self.region.notifyOnExit                = YES;
        self.region.notifyEntryStateOnDisplay   = YES;
        // 領域観測を開始する
        [self.manager startMonitoringForRegion:self.region];
        // 距離測定を開始する
        [self.manager startRangingBeaconsInRegion:self.region];
    }
}

/*
 * ビーコン監視 ストップ
 */
-(void) stopBeaconMonitoring
{
    {
        uint16_t uintMajor = (uint16_t)[self.detectionMajor  integerValue];
        uint16_t uintMinor = (uint16_t)[self.detectionMinor  integerValue];
        self.proximityUUID      = [[NSUUID alloc]initWithUUIDString:self.detectionUuid];
        self.region = [[CLBeaconRegion alloc]initWithProximityUUID:self.proximityUUID
                                                             major:uintMajor
                                                             minor:uintMinor
                                                        identifier:self.identifier];
        // いずれもデフォルト設定値
        self.region.notifyOnEntry               = YES;
        self.region.notifyOnExit                = YES;
        self.region.notifyEntryStateOnDisplay   = YES;
        // 領域観測を終了する
        [self.manager stopMonitoringForRegion:self.region];
        // 距離測定を終了する
        [self.manager stopRangingBeaconsInRegion:self.region];
    }
}

/*
 * アプリのロケーションサービスに関するアクセス許可状態に変更があると呼ばれる
 */
- (void)sendNotification:(NSString*)message
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate       = [[NSDate date] init];
    notification.timeZone       = [NSTimeZone defaultTimeZone];
    notification.alertBody      = message;
    notification.alertAction    = @"Open";
    notification.soundName      = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

/*
 * 現在のビーコン情報を返却
 */
- (CLBeacon *)getBeaconInfo
{
    return objectBeacon;
}

@end