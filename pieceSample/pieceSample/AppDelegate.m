//
//  pieceAppDelegate.m
//  piece
//
//  Created by ハマモト  on 2014/09/09.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "AppDelegate.h"
#import "FlyerViewController.h"
#import "InfoListViewController.h"
#import "CategoryViewController.h"
#import "TabbarViewController.h"
#import "FittingViewController.h"
#import "BarcodeReaderViewController.h"
#import "CheckinViewController.h"
#import "HistoryViewController.h"
#import "StampViewController.h"
#import "WebViewController.h"
#import "HistoryViewController.h"
#import "SosialViewController.h"
#import "ProfileViewController.h"
#import "CouponViewController.h"


@implementation AppDelegate


-(void)setConfig{
    [PieceCoreConfig setShopId:@"pieceSample"];
    [PieceCoreConfig setAppId:@""];
    [PieceCoreConfig setSplashInterval:[[NSNumber alloc]initWithFloat:2.0f ]];
    [PieceCoreConfig setAppKey:@"3dda3c1e8d60b512b7bd8eec730cf3ef"];
}

-(void)setThemeColor{
    self.theme = [[ThemeData alloc]initThemeCute];
}

//UITabBarController初期化
- (NSMutableArray *)getTabbarDataList
{
    NSMutableArray *tabbarDataList = [NSMutableArray array];


    
    SosialSettingData *sosialSetting = [[SosialSettingData alloc]init];
    FlyerViewController *flyerVc =[[FlyerViewController alloc] initWithNibName:@"FlyerViewController" bundle:nil];
    flyerVc.sosialSetting = sosialSetting;
    
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:flyerVc
                                                                imgName:@"icon_eye.png"
                                                          selectImgName:@"icon_eye.png"
                                                               tabTitle:@"image"
                                                                  title:@"装着イメージ"]];
    
//    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
//                               [[StampViewController alloc] initWithNibName:@"StampViewController" bundle:nil]
//                                                                imgName:@"icon_stamp.png"
//                                                          selectImgName:@"icon_stamp.png"
//                                                               tabTitle:@"Stamp"
//                                                                  title:@"Stamp"]];
    
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:[[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil]
                                                                imgName:@"tab_icon_shopping.png"
                                                          selectImgName:@"tab_icon_shopping.png"
                                                               tabTitle:@"Shopping"
                                                                  title:@"Shopping"]];
    
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[FittingViewController alloc] initWithNibName:@"FittingViewController" bundle:nil]
                                                                imgName:@"icon_fitting.png"
                                                          selectImgName:@"icon_fitting.png"
                                                               tabTitle:@"Fitting"
                                                                  title:@"フィッティング"]];
//    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
//                               [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil]
//                                                                imgName:@"icon_history.png"
//                                                          selectImgName:@"icon_history.png"
//                                                               tabTitle:@"History"
//                                                                  title:@"配送状況一覧"]];
//    NSMutableArray *cellList = [NSMutableArray array];
//    [cellList addObject:[[ProfileNameTableViewCell alloc]init]];
//    [cellList addObject:[[ProfileSexTableViewCell alloc]init]];
//    [cellList addObject:[[ProfileBirthdayTableViewCell alloc]init]];
//    [cellList addObject:[[ProfileAnniversaryTableViewCell alloc]init]];
//    [cellList addObject:[[ProfileAdressTableViewCell alloc]init]];
//    [cellList addObject:[[ProfileSendBtnTableViewCell alloc]init]];
//    ProfileViewController *profileVc = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
//    profileVc.cellList = cellList;
//    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:profileVc
//                                                                imgName:@"tab_icon_profile.png"
//                                                          selectImgName:@"tab_icon_profile.png"
//                                                               tabTitle:@"Profile"
//                                                                  title:@"プロフィール設定"]];
    
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CouponViewController alloc] initWithNibName:@"CouponViewController" bundle:nil]
                                                                imgName:@"tab_icon_coupon.png"
                                                          selectImgName:@"tab_icon_coupon.png"
                                                               tabTitle:@"Coupon"
                                                                  title:@"COUPON"]];
    
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
