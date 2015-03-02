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

@interface CoreDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic) bool isUpdate;
- (NSMutableArray *)getTabbarDataList;
-(void)setTabbarNumberWithVc:(BaseViewController *)vc index:(int)index;
@end
