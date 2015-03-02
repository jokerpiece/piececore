//
//  AppDelegate.m
//  pieceSample
//
//  Created by ハマモト  on 2015/02/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "AppDelegate.h"
#import "FlyerViewController.h"
#import "InfoListViewController.h"
#import "CategoryViewController.h"
#import "TabbarViewController.h"
#import "FittingViewController.h"
#import "BarcodeReaderViewController.h"
#import "CheckinViewController.h"
#import "SettingViewController.h"
#import "HistoryViewController.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [super application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions];
    [PieceCoreConfig setShopId:@"otonagokoro"];
    [PieceCoreConfig setAppId:@""];
    return YES;
}

//UITabBarController初期化
- (NSMutableArray *)getTabbarDataList
{
    NSMutableArray *tabbarDataList = [NSMutableArray array];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[FlyerViewController alloc] initWithNibName:@"FlyerViewController" bundle:nil]
                                                                imgName:@"tab_icon_flyer.png"
                                                          selectImgName:@"tab_icon_flyer.png"
                                                               tabTitle:@"Flyer"
                                                           titleImgName:@"sample_logo.png"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[InfoListViewController alloc] initWithNibName:@"InfoListViewController" bundle:nil]
                                                                imgName:@"tab_icon_news.png"
                                                          selectImgName:@"tab_icon_news.png"
                                                               tabTitle:@"Info"
                                                                  title:@"お知らせ"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil]
                                                                imgName:@"tab_icon_shopping.png"
                                                          selectImgName:@"tab_icon_shopping.png"
                                                               tabTitle:@"Shopping"
                                                                  title:@"カテゴリ一覧"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CouponViewController alloc] initWithNibName:@"CouponViewController" bundle:nil]
                                                                imgName:@"tab_icon_coupon.png"
                                                          selectImgName:@"tab_icon_coupon.png"
                                                               tabTitle:@"Coupon"
                                                                  title:@"クーポン"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[FittingViewController alloc] initWithNibName:@"FittingViewController" bundle:nil]
                                                                imgName:@"tab_icon_fitting.png"
                                                          selectImgName:@"tab_icon_fitting.png"
                                                               tabTitle:@"Fitting"
                                                                  title:@"フィッテイング"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[BarcodeReaderViewController alloc] initWithNibName:@"BarcodeReaderViewController" bundle:nil]
                                                                imgName:@"tab_icon_barcode.png"
                                                          selectImgName:@"tab_icon_barcode.png"
                                                               tabTitle:@"Barcode"
                                                                  title:@"バーコード読取り"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CheckinViewController alloc] initWithNibName:@"CheckinViewController" bundle:nil]
                                                                imgName:@"tab_icon_map.png"
                                                          selectImgName:@"tab_icon_map.png"
                                                               tabTitle:@"Map"
                                                                  title:@"店舗一覧"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil]
                                                                imgName:@"tab_icon_setting.png"
                                                          selectImgName:@"tab_icon_setting.png"
                                                               tabTitle:@"Profile"
                                                                  title:@"プロフィール"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil]
                                                                imgName:@"tab_icon_setting.png"
                                                          selectImgName:@"tab_icon_setting.png"
                                                               tabTitle:@"History"
                                                                  title:@"購入履歴"]];
    return tabbarDataList;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application

{
    [super applicationDidBecomeActive:application];
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
