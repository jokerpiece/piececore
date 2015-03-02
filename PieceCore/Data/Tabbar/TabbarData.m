//
//  TabbarData.m
//  piece
//
//  Created by ハマモト  on 2015/02/03.
//  Copyright (c) 2015年 ハマモト . All rights reserved.
//

#import "TabbarData.h"

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
