//
//  TabbarViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/09.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "TabbarViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    self.delegate = self;
    [super viewWillAppear:animated];
}

// タブが切替られたときに呼び出されるデリゲートメソッド
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [tabBarController.moreNavigationController popToRootViewControllerAnimated:YES];
        UINavigationController *navigationController = (UINavigationController *)viewController;
        DLog(@"タブ切り替え");
        [navigationController popToRootViewControllerAnimated:NO];
    }
}

@end
