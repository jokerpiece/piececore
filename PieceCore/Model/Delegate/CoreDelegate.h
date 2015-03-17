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

@interface CoreDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic) UIWindow *window;
@property (nonatomic) UITabBarController *tabBarController;
@property (nonatomic) ThemeData *theme;
@property (nonatomic) bool isUpdate;
- (NSMutableArray *)getTabbarDataList;
-(void)setConfig;
-(void)setThemeColor;
-(void)setTabbarNumberWithVc:(BaseViewController *)vc index:(int)index;
@end
