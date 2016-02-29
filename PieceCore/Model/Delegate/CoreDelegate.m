//
//  CoreDelegate.m
//  piece
//
//  Created by ハマモト  on 2015/02/03.
//  Copyright (c) 2015年 ハマモト . All rights reserved.
//

#import "CoreDelegate.h"
#import "PieceCoreConfig.h"
#import "FlyerViewController.h"
#import "InfoListViewController.h"
#import "CouponViewController.h"
#import "CategoryViewController.h"
#import "linepayReservSquareViewController.h"
#import "OrderDataCheckViewController.h"
#import "PlayHologramYoutubeViewController.h"
#import "PlayYoutubeViewController.h"
#import "UploadYoutubeViewController.h"
#import "ReminderViewController.h"
#import "PayPalMobile.h"



@implementation CoreDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [self setConfig];
    [self setGoogleAnalitics];
    [self nex8SendOpenStatus];
    [self setPieceTitle];
    [self setThemeColor];
    [self setNavibarTitleAttributes];
    [self registDeviceToken];
    [self setTabBarController];
    [self splashIntarval];
    [self moveScreenWithLaunchOptions:launchOptions];
    [self LocalNotificationUpdate:launchOptions];
    [self paypal];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return YES;
}
-(void)setConfig{
}

-(void)setGoogleAnalitics{
    
    if (![PieceCoreConfig isGoogleAnalitics]) {
        return;
    }
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    // Optional: configure GAI options.
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
    [GAI sharedInstance].dispatchInterval = 120;
    gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release
}


-(void)nex8SendOpenStatus{
    if ([Common isNotEmptyString:[PieceCoreConfig nex8Key]]) {
//        self.nex8Tracker = [Nex8Tracking trackerWithSdkKey:[PieceCoreConfig nex8Key]];
//        [self.nex8Tracker sendOpenedApp];
    }
}

- (void)sendLocalNotificationForMessage:(NSString *)message
{
    DLog(@"send!");
    UILocalNotification *localNotification = [UILocalNotification new];
    localNotification.alertBody = message;
    localNotification.fireDate = [NSDate date];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)splashIntarval{
    if ([PieceCoreConfig splashInterval] != nil) {
        [NSThread sleepForTimeInterval:[PieceCoreConfig splashInterval].floatValue];
    }
}
-(void)setPieceTitle{
    [PieceCoreConfig setTitleNameData:[[TitleNameData alloc]initForEnglishDefault]];
}
-(void)setThemeColor{
    self.theme = [[ThemeData alloc]initThemeDefault];
}
-(void)setNavibarTitleAttributes{
    [UINavigationBar appearance].barTintColor = self.theme.navigationBarColor;
    [UINavigationBar appearance].backItem.title = @"戻る";
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.f, -0.5f);
    shadow.shadowColor = self.theme.navigationTitleShadowColor;
    shadow.shadowBlurRadius = 0.f;
    
    NSDictionary *navbarTitleTextAttributes = @{ NSForegroundColorAttributeName : self.theme.navigationTitleColor,
                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:22.0f],
                                                 NSShadowAttributeName: shadow
                                                 };
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
}

-(void)registDeviceToken{
    NSString *currentVersion = [[UIDevice currentDevice] systemVersion];
    if ([currentVersion compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending){
        // i0S7以前の処理
        // デバイストークン取得申請
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge|
                                                                                UIRemoteNotificationTypeSound|
                                                                                UIRemoteNotificationTypeAlert)];
    } else {
        // iOS8の処理
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

-(void)moveScreenWithLaunchOptions:(NSDictionary *)launchOptions{
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo != nil) {
        
        NSDictionary *info = [userInfo objectForKey:@"info"];
        NSString *infoType = [info objectForKey:@"type"];
        NSString *infoId = [info objectForKey:@"id"];
        
        if ([infoType isEqualToString:@"2"]) {
            [self moveToFliyer:infoId];
        } else if ([infoType isEqualToString:@"3"]){
            [self moveToCoupon:infoId];
        } else {
            [self moveToNews:infoId];
        }
    }
}

-(void)LocalNotificationUpdate:(NSDictionary*)launchOptions{
    // UIApplicationLaunchOptionsLocalNotificationKeyをキーにして、情報を取り出す
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if(notification != nil) {
        //リマインダーを呼び出して通知を（修正が大変なので）全て作りなおす
        ReminderViewController *reVC = [[ReminderViewController alloc]init];
        [reVC setReminderNotificate];
    }
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
                                 NSForegroundColorAttributeName : self.theme.tabTitleNomalColor};
    
    NSDictionary *attributes2 = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f],
                                  NSForegroundColorAttributeName : self.theme.tabTitleSelectColor};
    
    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:attributes2 forState:UIControlStateSelected];
    [UITabBar appearance].tintColor = self.theme.tabBarSelectColor;
    [UITabBar appearance].barTintColor = self.theme.tabBarBackColor;
    [(UITabBarController *)self.tabBarController setViewControllers:navigationControllerList animated:NO];
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
}

//必要であればオーバーライド
-(void)setTabbarNumberWithVc:(BaseViewController *)vc index:(int)index{
    if ([vc isKindOfClass:[FlyerViewController class]]) {
        [PieceCoreConfig setTabnumberFlyer:[[NSNumber alloc] initWithInt:index]];
    } else if ([vc isKindOfClass:[InfoListViewController class]]) {
        [PieceCoreConfig setTabnumberInfo:[[NSNumber alloc] initWithInt:index]];
    } else if ([vc isKindOfClass:[CouponViewController class]]) {
        [PieceCoreConfig setTabnumberCoupon:[[NSNumber alloc] initWithInt:index]];
    } else if ([vc isKindOfClass:[CategoryViewController class]]) {
        [PieceCoreConfig setTabnumberShopping:[[NSNumber alloc] initWithInt:index]];
    }
}

- (NSMutableArray *)getTabbarDataList {
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
//    if (self.nex8Tracker) {
//        [self.nex8Tracker endSession];
//    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
//    if (self.nex8Tracker) {
//        [self.nex8Tracker startSession];
//    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application

{
    [self checkVersion];
    if (application.applicationIconBadgeNumber != 0) {
        application.applicationIconBadgeNumber = 0;
        [self moveToNews:@""];
        
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// デバイストークンを受信した際の処理
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    DLog(@"Success : Regist device token to APNS. (%@)", deviceToken);
    
    NSString *strDeviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                 stringByReplacingOccurrencesOfString:@">" withString:@""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""];
    DLog(@"Edited device token to APNS. (%@)", strDeviceToken);
    [Common setDeviceToken:strDeviceToken];
    [self postDeviceToken:strDeviceToken];
    
    
}

- (void)postDeviceToken:(NSString *)deviceToken {
    
    // prepare url.
    
    NSString* content = [NSString stringWithFormat:@"device_token=%@&uuid=%@&app_id=%@&os_type=%@", deviceToken,[Common getUuid],[PieceCoreConfig shopId],OsType];
    
    NSURL* url = [NSURL URLWithString:SendTokenUrl];
    
    // create instance.
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc]initWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding]];
    
    // post.
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    if(error) DLog(@"error = %@", error);
    
    // get result.
    NSString* resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    DLog(@"%@", resultString);
    
}



// プッシュ通知を受信した際の処理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSNumber *badge = [apsInfo objectForKey:@"badge"];
    UIAlertView *alertView = [[UIAlertView alloc] init];
    [alertView setTitle:@"お知らせ"];
    [alertView setMessage:alert];
    [alertView addButtonWithTitle:@"OK"];
    [alertView show];
    
    NSDictionary *info = [userInfo objectForKey:@"info"];
    
    if (application.applicationState == UIApplicationStateInactive)
    {//アプリがバックグラウンドで起動している時に、PUSH通知からアクティブになった場合
        NSString *infoType = [info objectForKey:@"type"];
        NSString *infoId = [info objectForKey:@"id"];
        
        if ([infoType isEqualToString:@"2"]) {
            [self moveToFliyer:infoId];
            return;
        } else if ([infoType isEqualToString:@"3"]){
            [self moveToCoupon:infoId];
            return;
        } else {
            [self moveToNews:infoId];
            return;
        }
        
    }
    
    if (application.applicationState == UIApplicationStateActive)
    {//アプリがフォアグラウンドで起動している時にPUSH通知を受信した場合
        if (![PieceCoreConfig tabnumberInfo]) {
            UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
            [[tabController.viewControllers objectAtIndex:[PieceCoreConfig tabnumberInfo].intValue] tabBarItem].badgeValue = badge.stringValue;
        }
        
    }
    
    DLog(@"サーバーから届いている中身一覧: %@",[userInfo description]);
    
    
    if(application.applicationState == UIApplicationStateInactive)
    {
        //バックグラウンドにいる状態
        NSString *infoType = [info objectForKey:@"type"];
        NSString *infoId = [info objectForKey:@"id"];
        if ([infoType isEqualToString:@"2"]) {
            [self moveToFliyer:infoId];
            return;
        }
    }else if(application.applicationState == UIApplicationStateActive){
        //アクティブ
    }
    
    
    DLog(@"%@ %@ %@",[info objectForKey:@"title"],[info objectForKey:@"type"],[info objectForKey:@"id"]);
    
    //application.applicationIconBadgeNumber = 0;
}
//ローカルプッシュ
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // アプリ起動中(フォアグラウンド)に通知が届いた場合
    if(application.applicationState == UIApplicationStateActive) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:notification forKey:UIApplicationLaunchOptionsLocalNotificationKey];
        [self LocalNotificationUpdate:dic];
    }
    // アプリがバックグラウンドにある状態で通知が届いた場合
    if(application.applicationState == UIApplicationStateInactive) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:notification forKey:UIApplicationLaunchOptionsLocalNotificationKey];
        [self LocalNotificationUpdate:dic];
    }
}

-(void)moveToFliyer:(NSString *)infoId{
    
    if ([PieceCoreConfig tabnumberFlyer]) {
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        
        FlyerViewController * resultVC;
        UINavigationController* nc = [tabController.viewControllers objectAtIndex:[PieceCoreConfig tabnumberFlyer].intValue];
        
        if (nc.viewControllers.count != 0){
            resultVC = [nc.viewControllers objectAtIndex:0];
            resultVC.fliyerId = infoId;
        }
        
        //遷移先へ移動
        [tabController setSelectedViewController: nc];
    }
    
}

-(void)moveToCoupon:(NSString *)infoId{
    
    if ([PieceCoreConfig tabnumberCoupon]) {
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        
        CouponViewController * resultVC;
        UINavigationController* nc = [tabController.viewControllers objectAtIndex:[PieceCoreConfig tabnumberCoupon].intValue];
        
        if (nc.viewControllers.count != 0){
            
            resultVC = [nc.viewControllers objectAtIndex:0];
            resultVC.mode = getCoupon;
            resultVC.couponId = infoId;
            resultVC.mode = getCoupon;
        }
        
        //遷移先へ移動
        [tabController setSelectedViewController: nc];
    }
    
}
-(void)moveToNews:(NSString *)infoId{
    
    if ([PieceCoreConfig tabnumberInfo]) {
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController* nc = [tabController.viewControllers objectAtIndex:[PieceCoreConfig tabnumberInfo].intValue];
        //遷移先へ移動
        [tabController setSelectedViewController: nc];
    }
    
}


/**
 * バージョン判定
 * ユーザのバージョンが前のバージョンの場合はアラートを表示
 */
- (void)checkVersion{
    self.isUpdate = NO;
    if ([PieceCoreConfig appId].length == 0) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",[PieceCoreConfig appId]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                             
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    if (error.code ){
        return;
    }
    
    NSDictionary *dataDic  = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:&error];
    
    
    NSArray *reslutList = (NSArray *)[dataDic objectForKey:@"results"];
    if (reslutList.count == 0) {
        return;
    }
    NSDictionary *results = [[dataDic objectForKey:@"results"] objectAtIndex:0];
    
    NSString *latestVersion = [results objectForKey:@"version"];
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSComparisonResult versionResult = [latestVersion compare:currentVersion options:NSNumericSearch];
    
    if (versionResult == NSOrderedDescending) {
        self.isUpdate = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:@"最新バージョンが入手可能です。\nアップデートして下さい。"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"アップデート", nil];
        [alert show];
    }
}


/**
 * AlertViewで"アップデート"を選択した際の処理
 * AppStoreに遷移
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        NSString* urlString;
        
        //iOSのバージョンでAppStoreに遷移するURLスキームの変更
        if( [self isIOS7]){
            //iOS7以上
            urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",[PieceCoreConfig appId]];
        }else{
            urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",[PieceCoreConfig appId]];
        }
        
        NSURL* url= [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

/**
 *  実行中の環境がiOS7以上かどうかを判定する
 *  ios7以上ならTRUEを返す
 */
- (BOOL)isIOS7
{
    NSArray  *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    NSInteger iOsVersionMajor  = [[aOsVersions objectAtIndex:0] intValue];
    return (iOsVersionMajor >= 7);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    [[UIApplication sharedApplication].delegate.window.rootViewController
     dismissViewControllerAnimated:YES completion:nil];
    
    if ([[url host]isEqualToString:[[NSURL URLWithString:[PieceCoreConfig linePayConfirmUrl]]host]]) {
    //if ([[url absoluteString] isEqualToString:[PieceCoreConfig linePayConfirmUrl]]) {
       
        linepayReservSquareViewController *vc = [[linepayReservSquareViewController alloc]initWithNibName:@"linepayReservSquareViewController" bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
        return NO;
        
    } else if ([[url host]isEqualToString:UrlSchemeHostUploadYoutube] || [[url host]isEqualToString:UrlSchemeHostInputMessage] || [[url host]isEqualToString:UrlSchemeHostQuestion]) {

        
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        UINavigationController* nc = [tabController.viewControllers objectAtIndex:tabController.selectedIndex];
        [nc popToRootViewControllerAnimated:YES];
        
        //動画アップロード
        OrderDataCheckViewController *vc = [[OrderDataCheckViewController alloc]initWithNibName:@"OrderDataCheckViewController" bundle:nil];
        NSDictionary *params = [Common dictionaryFromQueryString:[url query]];
        vc.order_num = params[@"order_num"];
        UINavigationController* rootController = [[UINavigationController alloc]initWithRootViewController:vc];//追加
        [self.window.rootViewController presentViewController:rootController animated:YES completion:nil];
        return NO;
    } else if ([[url host]isEqualToString:UrlSchemeHostRapping]) {
        //ラッピング用バーコードから起動
        NSDictionary *params = [Common dictionaryFromQueryString:[url query]];
        
        self.rappingSelectController = [RappingSelectController alloc];
        [self.rappingSelectController presentViewWithOrderId:params parnentVc:self.window.rootViewController];
        
        
        
    }
    return YES;
}
-(NSDictionary*)dictionaryFromQueryString:(NSString *)query
{
    // クエリ文字列が設定されている場合だけ、解析処理をします。
    if (query)
    {
        // 解析しながら、名前と値をここに蓄えて行きます。
        NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
        
        // クエリ文字列を "&" で分割して、ひとつひとつの "名前=値" の組に分解します。
        NSArray* parameters = [query componentsSeparatedByString:@"&"];
        
        for (NSString* parameter in parameters)
        {
            // "&" で区切られた文字列が、空文字ではないものを解析します。
            if (parameter.length > 0)
            {
                // 名前と値を分解します。
                NSArray* elements = [parameter componentsSeparatedByString:@"="];
                
                // 名前は UTF8 でエンコードされているものとしてデコードします。
                id key = [elements[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                // 値があればそれを UTF8 でデコードして取得します。名前だけで値の指定が無い場合は、ここでは値を @YES とみなします。
                id value = (elements.count == 1 ? @YES : [elements[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
                
                // 取得した名前と値を保存します。重複は考慮していません。
                [result setObject:value forKey:key];
            }
        }
        // 取得した値と名前の組を、読み取り専用のインスタンスで返します。
        return [result copy];
    }
    else
    {
        // クエリ文字列が nil だった場合は、結果も nil を返します。
        return nil;
    }
}
/**
 * PayPal初期化
 */
-(void)paypal{
    if ([PieceCoreConfig isPayPal]){
        [PayPalMobile initializeWithClientIdsForEnvironments
         :@{PayPalEnvironmentProduction : [PieceCoreConfig payPalEnvironmentProductionClientId],
            PayPalEnvironmentSandbox : [PieceCoreConfig payPalEnvironmentSandboxClientId]
            }];
    }
}
@end
