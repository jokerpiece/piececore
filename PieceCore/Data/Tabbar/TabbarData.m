//
//  TabbarData.m
//  piece
//
//  Created by ハマモト  on 2015/02/03.
//  Copyright (c) 2015年 ハマモト . All rights reserved.
//

#import "TabbarData.h"
#import "FlyerViewController.h"
#import "InfoListViewController.h"
#import "CategoryViewController.h"
#import "FittingViewController.h"
#import "StampViewController.h"
#import "BarcodeReaderViewController.h"
#import "ProfileViewController.h"
#import "HistoryViewController.h"
#import "ReminderViewController.h"

@implementation TabbarData
-(id)initWithViewController:(BaseViewController *)viewController
                      imgName:(NSString *)imgName
                selectImgName:(NSString *)selectImgName
                        tabTitle:(NSString *)tabTitle
                        title:(NSString *)title

{
    if (self = [super init]) {
        self.viewController = viewController;
        self.imgName = imgName;
        self.selectImgName = selectImgName;
        self.tabTitle = tabTitle;
        self.title = title;
        self.viewController.title = title;
    }
    return self;
}

-(id)initWithViewController:(BaseViewController *)viewController
                   tabTitle:(NSString *)tabTitle
                      title:(NSString *)title

{
    if (self = [super init]) {
        self.viewController = viewController;

        if ([viewController isKindOfClass:[FlyerViewController class]]) {
            self.selectImgName = @"tab_icon_flyer.png";
            self.imgName = @"tab_icon_flyer.png";
            
        } else if ([viewController isKindOfClass:[InfoListViewController class]]) {
            self.selectImgName = @"tab_icon_news.png";
            self.imgName = @"tab_icon_news.png";
            
        } else if ([viewController isKindOfClass:[CategoryViewController class]]) {
            self.selectImgName = @"tab_icon_shopping.png";
            self.imgName = @"tab_icon_shopping.png";
            
        } else if ([viewController isKindOfClass:[CouponViewController class]]) {
            self.selectImgName = @"tab_icon_coupon.png";
            self.imgName = @"tab_icon_coupon.png";
            
        } else if ([viewController isKindOfClass:[FittingViewController class]]) {
            self.selectImgName = @"icon_fitting.png";
            self.imgName = @"icon_fitting.png";
            
        } else if ([viewController isKindOfClass:[StampViewController class]]) {
            self.selectImgName = @"icon_stamp.png";
            self.imgName = @"icon_stamp.png";
            
        } else if ([viewController isKindOfClass:[BarcodeReaderViewController class]]) {
            self.selectImgName = @"tab_icon_barcode.png";
            self.imgName = @"tab_icon_barcode.png";
            
        } else if ([viewController isKindOfClass:[ProfileViewController class]]) {
            self.selectImgName = @"tab_icon_profile.png";
            self.imgName = @"tab_icon_profile.png";
            
        } else if ([viewController isKindOfClass:[HistoryViewController class]]) {
            self.selectImgName = @"icon_history.png";
            self.imgName = @"icon_history.png";
            
        }  else if ([viewController isKindOfClass:[ReminderViewController class]]) {
            self.selectImgName = @"icon_birthday.png";
            self.imgName = @"icon_birthday.png";
            
        }
        self.tabTitle = tabTitle;
        self.title = title;
        self.viewController.title = title;
    }
    return self;
}

-(id)initWithViewController:(BaseViewController *)viewController
                    imgName:(NSString *)imgName
              selectImgName:(NSString *)selectImgName
                   tabTitle:(NSString *)tabTitle
               titleImgName:(NSString *)titleImgName
{
    if (self = [super init]) {
        self.viewController = viewController;
        self.imgName = imgName;
        self.selectImgName = selectImgName;
        self.tabTitle = tabTitle;
        self.titleImgName = titleImgName;
        viewController.titleImgName = titleImgName;
    }
    return self;
}

@end
