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


@implementation AppDelegate


-(void)setConfig{
    [PieceCoreConfig setShopId:@"pieceSample"];
    [PieceCoreConfig setAppKey:@"1111"];
    [PieceCoreConfig setAppId:@""];
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
                                                                  title:@"FLYER"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[InfoListViewController alloc] initWithNibName:@"InfoListViewController" bundle:nil]
                                                                imgName:@"tab_icon_news.png"
                                                          selectImgName:@"tab_icon_news.png"
                                                               tabTitle:@"Info"
                                                                  title:@"INFO"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil]
                                                                imgName:@"tab_icon_shopping.png"
                                                          selectImgName:@"tab_icon_shopping.png"
                                                               tabTitle:@"Shopping"
                                                                  title:@"SHOPPING"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CouponViewController alloc] initWithNibName:@"CouponViewController" bundle:nil]
                                                                imgName:@"tab_icon_coupon.png"
                                                          selectImgName:@"tab_icon_coupon.png"
                                                               tabTitle:@"Coupon"
                                                                  title:@"COUPON"]];
    return tabbarDataList;
}

- (void)setTabBarController
{
    self.window =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController = [[TabbarViewController alloc] init];
    NSMutableArray *navigationControllerList = [NSMutableArray array];
    NSMutableArray *tabbarDataList = [self getTabbarDataList];
    
    int i = 0;
    for (TabbarData *tabbarData in tabbarDataList) {
        if (tabbarData.viewController != nil) {
            [self setTabbarNumberWithVc:tabbarData.viewController index:i];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarData.viewController];
            navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:tabbarData.tabTitle
                                                                            image:[[UIImage imageNamed:tabbarData.imgName] imageWithRenderingMode:UIImageRenderingModeAutomatic]
                                                                    selectedImage:[[UIImage imageNamed:tabbarData.selectImgName] imageWithRenderingMode:UIImageRenderingModeAutomatic]];
            navigationController.tabBarItem.title = tabbarData.tabTitle;
            [navigationControllerList addObject:navigationController];
            i++;
        }
    }
    
    
    
    //タブのタイトル位置設定
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -1)];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f],
                                 NSForegroundColorAttributeName : [UIColor grayColor]};
    
    NSDictionary *attributes2 = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f],
                                  NSForegroundColorAttributeName : [UIColor darkGrayColor]};
    
    //タブのタイトル色指定
    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    //タブのタイトル色指定(選択中)
    [[UITabBarItem appearance] setTitleTextAttributes:attributes2 forState:UIControlStateSelected];
    
    //タブアイコン選択中の色
    [UITabBar appearance].tintColor = [UIColor darkGrayColor];
    //タブバーの背景色
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
    
    //ビューを Controllerに追加
    
    [(UITabBarController *)self.tabBarController setViewControllers:navigationControllerList animated:NO];
    
    //windowに Controllerのビュー追加
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
}

-(void)setNavibarTitleAttributes{
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    [UINavigationBar appearance].backItem.title = @"戻る";
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.f, -0.5f);
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowBlurRadius = 0.f;
    
    NSDictionary *navbarTitleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:22.0f],
                                                 NSShadowAttributeName: shadow,
                                                 NSShadowAttributeName : [UIColor blackColor]
                                                 };
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
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
