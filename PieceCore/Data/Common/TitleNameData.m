//
//  TitleNameData.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/27.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "TitleNameData.h"

@implementation TitleNameData
- (id)initForEnglishDefault
{
    self = [super init];
    if (self) {
        self.webViewTitle = @"ITEM";
        self.flyerTitle = @"FLYER";
        self.stampTitle = @"STAMP";
        self.categoryTitle = @"SHOPPING";
        self.itemListTitle = @"ITEMLIST";
        self.fittingTitle = @"FITTING";
        self.profileTitle = @"PROFILE";
        self.getCouponTitle = @"GET COUPON";
        self.useCouponTitle = @"USE COUPON";
        self.infoTitle = @"INFOMATION";
        self.newsTitle = @"NEWS";
        self.barcodeTitle = @"BARCODE";
        self.historyTitle = @"DELIVERLIST";
        self.sosialTitle = @"SOSIAL";
        self.twitterTitle = @"TWITTER";
        self.movieListTitle = @"MOVIELIST";
    }
    return self;
}
- (id)initForJapanaseDefault
{
    self = [super init];
    if (self) {
        self.webViewTitle = @"商品詳細";
        self.flyerTitle = @"フライヤー";
        self.stampTitle = @"スタンプラリー";
        self.categoryTitle = @"ショッピング";
        self.itemListTitle = @"商品一覧";
        self.fittingTitle = @"フィッティング";
        self.profileTitle = @"プロフィール";
        self.getCouponTitle = @"クーポン取得";
        self.useCouponTitle = @"クーポン使用";
        self.infoTitle = @"お知らせ";
        self.newsTitle = @"お知らせ詳細";
        self.barcodeTitle = @"バーコード";
        self.historyTitle = @"配送状況";
        self.sosialTitle = @"SNS連携";
        self.twitterTitle = @"Twtter";
        self.movieListTitle = @"動画リスト";
    }
    return self;
}
@end
