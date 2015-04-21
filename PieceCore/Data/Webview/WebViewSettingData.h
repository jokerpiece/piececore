//
//  WebViewSettingData.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/19.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
typedef enum {
    BrowserBtnPositionDown,
    BrowserBtnPositionMiddle,
    BrowserBtnPositionUp
} BrowserBtnPosition;

@interface WebViewSettingData : NSObject
@property (nonatomic) SVProgressHUDMaskType maskType;
@property (nonatomic) BrowserBtnPosition browserBtnPosition;
@property (nonatomic) NSString *url;
@property (nonatomic) bool isDispBrowserBackBtn;
@property (nonatomic) bool isDispBrowserNextBtn;
@property (nonatomic) bool isReloadEveryTime;
/* key:URL value:DOM (ex:document.forms[0].Coupon.value) */
@property (nonatomic) NSMutableDictionary *couponInputDomList;
@end
