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
#import "TwitterViewController.h"
#import "UploadYoutubeViewController.h"
#import "PlayHologramYoutubeViewController.h"
#import "RappingBarcodeViewController.h"


@implementation AppDelegate


-(void)setConfig{
    [PieceCoreConfig setShopId:@"kodomogokoro"];
    [PieceCoreConfig setAppKey:@""];
    [PieceCoreConfig setAppId:@""];
    [PieceCoreConfig setLinePay:YES];
    [PieceCoreConfig setLinePayConfirmUrl:@"piece://pay"];
    [PieceCoreConfig setCookieDomainName:@"t.otonagokoro.com"];
}

//UITabBarController初期化
- (NSMutableArray *)getTabbarDataList
{
    NSMutableArray *tabbarDataList = [NSMutableArray array];
    
    
//    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:[[UploadYoutubeViewController alloc]initWithNibName:@"UploadYoutubeViewController" bundle:nil ] tabTitle:@"youtube" title:@"youtube"]];
//    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:[[PlayHologramYoutubeViewController alloc]initWithNibName:@"PlayHologramYoutubeViewController" bundle:nil ] tabTitle:@"play" title:@"play"]];
//    
    
    
    
    RappingBarcodeViewController *vc = [[RappingBarcodeViewController alloc] initWithNibName:@"RappingBarcodeViewController" bundle:nil];
    vc.barcodeTitle = @"プレゼントのメッセージがあります。\nQRコードを読み取って下さい。";
    
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:vc
                                                               tabTitle:@"Barcode"
                                                                  title:@"Barcode"]];
    
    FlyerViewController *flyerVc = [[FlyerViewController alloc] initWithNibName:@"FlyerViewController" bundle:nil];
    flyerVc.titleImgName = @"sample_logo.png";
    
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:flyerVc
                                                               tabTitle:@"Flyer"
                                                                  title:@"FLYER"]];
    
    InfoListViewController *infoVc = [[InfoListViewController alloc]initWithNibName:@"InfoListViewController" bundle:nil];
    infoVc.titleImgName= @"sample_logo.png";
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               infoVc
                                                               tabTitle:@"Info"
                                                                  title:@"INFOMATION"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil]
                                                               tabTitle:@"Shopping"
                                                                  title:@"SHOPPING"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CouponViewController alloc] initWithNibName:@"CouponViewController" bundle:nil]
                                                               tabTitle:@"Coupon"
                                                                  title:@"COUPON"]];
    
    TwitterViewController *twitterVc =[[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
    twitterVc.userAcount = @"@SplatoonJP";
//    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:twitterVc
//                               
//                                                               tabTitle:@"Twitter"
//                                                                  title:@"TWITTER"]];
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
