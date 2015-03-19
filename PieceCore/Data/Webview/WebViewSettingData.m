//
//  WebViewSettingData.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/19.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "WebViewSettingData.h"

@implementation WebViewSettingData
- (id) init {
    if (self = [super init]) {
        self.maskType = SVProgressHUDMaskTypeBlack;
        self.browserBtnPosition = BrowserBtnPositionMiddle;
        self.isDispBrowserBackBtn = YES;
        self.isDispBrowserNextBtn = YES;
        self.isReloadEveryTime = NO;
        self.url = @"";
    }
    return self;
}
@end
