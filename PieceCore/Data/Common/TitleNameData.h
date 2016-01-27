//
//  TitleNameData.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/27.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleNameData : NSObject
@property (nonatomic) NSString *flyerTitle;
@property (nonatomic) NSString *webViewTitle;
@property (nonatomic) NSString *stampTitle;
@property (nonatomic) NSString *categoryTitle;
@property (nonatomic) NSString *itemListTitle;
@property (nonatomic) NSString *fittingTitle;
@property (nonatomic) NSString *historyTitle;
@property (nonatomic) NSString *profileTitle;
@property (nonatomic) NSString *getCouponTitle;
@property (nonatomic) NSString *useCouponTitle;
@property (nonatomic) NSString *infoTitle;
@property (nonatomic) NSString *newsTitle;
@property (nonatomic) NSString *barcodeTitle;
@property (nonatomic) NSString *sosialTitle;
@property (nonatomic) NSString *twitterTitle;
@property (nonatomic) NSString *movieListTitle;
- (id)initForEnglishDefault;
- (id)initForJapanaseDefault;
@end
