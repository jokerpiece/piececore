//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Common.h"
#import "FlyerViewController.h"
#import "CouponViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "TabbarData.h"
#import "TabbarViewController.h"
#import "ThemeData.h"
#import <CoreLocation/CoreLocation.h>
#import "GetPointView.h"
#import "RappingSelectController.h"
#import <Google/Analytics.h>
//#import <Nex8Tracking/Nex8Tracking.h>

@protocol PieceCoreDelegate
-(void)beaconDidEnterRegion;
@end

@interface CoreDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
@property (nonatomic,weak) id delegate;
@property (nonatomic) UIWindow *window;
@property (nonatomic) UITabBarController *tabBarController;
@property (nonatomic) ThemeData *theme;
@property (nonatomic) bool isUpdate;
@property (strong, nonatomic) GetPointView *pointView;
@property (nonatomic) RappingSelectController *rappingSelectController;
//@property (strong, nonatomic) NEXTracker *nex8Tracker;

@property (strong, nonatomic) CLLocationManager     *manager;
@property (strong, nonatomic) CLBeaconRegion        *region;
@property (strong, nonatomic) NSUUID                *proximityUUID;
@property (strong, nonatomic) NSString              *identifier;
@property uint16_t                                  major;
@property uint16_t                                  minor;
@property (nonatomic) bool isCheckIn;

- (NSMutableArray *)getTabbarDataList;
-(void)setConfig;
-(void)setThemeColor;
-(void)setTabbarNumberWithVc:(BaseViewController *)vc index:(int)index;
-(void)setGoogleAnalitics;

@end
