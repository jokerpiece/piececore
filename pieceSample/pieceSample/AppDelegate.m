//
//  pieceAppDelegate.m
//  piece
//
//  Created by ハマモト  on 2014/09/09.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "AppDelegate.h"
#import "FlyerViewController.h"
#import "StampViewController.h"
#import "WebViewController.h"
#import "FittingViewController.h"
#import "TabbarViewController.h"
#import "HistoryViewController.h"
#import "SosialViewController.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [super application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions];
    [PieceCoreConfig setShopId:@"pieceSample"];
    [PieceCoreConfig setAppId:@""];
    return YES;
}

-(void)setThemeColor{
    self.theme = [[ThemeData alloc]initThemeCute];
}

//UITabBarController初期化
- (NSMutableArray *)getTabbarDataList
{
    NSMutableArray *tabbarDataList = [NSMutableArray array];


    WebViewController *shop = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil url:@"http://pushcolor.com/" maskType:SVProgressHUDMaskTypeBlack];
    shop.isSnsEnable = YES;
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:shop
                                                                imgName:@"tab_icon_shopping.png"
                                                          selectImgName:@"tab_icon_shopping.png"
                                                               tabTitle:@"Shopping"
                                                                  title:@"ショッピング"]];

    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[SosialViewController alloc] initWithNibName:@"SosialViewController" bundle:nil]
                                                                imgName:@"tab_icon_flyer.png"
                                                          selectImgName:@"tab_icon_flyer.png"
                                                               tabTitle:@"Flyer"
                                                                  title:@"装着例"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[StampViewController alloc] initWithNibName:@"StampViewController" bundle:nil]
                                                                imgName:@"tab_icon_news.png"
                                                          selectImgName:@"tab_icon_news.png"
                                                               tabTitle:@"Info"
                                                                  title:@"スタンプラリー"]];

    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[FittingViewController alloc] initWithNibName:@"FittingViewController" bundle:nil]
                                                                imgName:@"tab_icon_coupon.png"
                                                          selectImgName:@"tab_icon_coupon.png"
                                                               tabTitle:@"Fitting"
                                                                  title:@"フィッティング"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil]
                                                                imgName:@"tab_icon_coupon.png"
                                                          selectImgName:@"tab_icon_coupon.png"
                                                               tabTitle:@"History"
                                                                  title:@"配送状況"]];
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
