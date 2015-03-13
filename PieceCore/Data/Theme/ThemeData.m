//
//  ThemeData.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/13.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ThemeData.h"

@implementation ThemeData
- (id) initThemeDefault {
    if (self = [super init]) {
        self.navigationBarColor = [UIColor whiteColor];
        self.navigationTitleColor = [UIColor darkGrayColor];
        self.navigationTitleShadowColor = [UIColor blackColor];
        self.tabBarBackColor = [UIColor whiteColor];
        self.tabBarSelectColor = [UIColor darkGrayColor];
        self.tabTitleNomalColor = [UIColor grayColor];
        self.tabTitleSelectColor = [UIColor darkGrayColor];
    }
    return self;
}

- (id) initThemeCute {
    if (self = [super init]) {
        self.navigationBarColor = [UIColor colorWithRed:1.00 green:0.98 blue:0.98 alpha:1.0];
        self.navigationTitleColor = [UIColor colorWithRed:0.88 green:0.16 blue:0.29 alpha:1.0];
        self.navigationTitleShadowColor = [UIColor whiteColor];
        self.tabBarBackColor = [UIColor colorWithRed:1.00 green:0.98 blue:0.98 alpha:1.0];
        self.tabBarSelectColor = [UIColor colorWithRed:0.88 green:0.16 blue:0.29 alpha:1.0];
        self.tabTitleNomalColor = [UIColor grayColor];
        self.tabTitleSelectColor = [UIColor colorWithRed:0.88 green:0.16 blue:0.29 alpha:1.0];
    }
    return self;
}
@end
