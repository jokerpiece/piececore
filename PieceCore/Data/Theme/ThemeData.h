//
//  ThemeData.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/13.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ThemeData : NSObject
@property (nonatomic) UIColor *navigationBarColor;
@property (nonatomic) UIColor *navigationTitleColor;
@property (nonatomic) UIColor *navigationTitleShadowColor;
@property (nonatomic) UIColor *tabTitleNomalColor;
@property (nonatomic) UIColor *tabTitleSelectColor;
@property (nonatomic) UIColor *tabBarBackColor;
@property (nonatomic) UIColor *tabBarSelectColor;
- (id) initThemeDefault;
- (id) initThemeCute;
@end
