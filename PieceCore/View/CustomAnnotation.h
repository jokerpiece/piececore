//
//  CustomAnnotation.h
//  piece
//
//  Created by ハマモト  on 2014/10/07.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject<MKAnnotation>
@property (nonatomic, copy) NSString* title;         //吹き出しに表示するタイトル
@property (nonatomic, copy) NSString* subtitle;   //吹き出しに表示するサブタイトル

- (id) initWithCoordinate:(CLLocationCoordinate2D) coordinate;
@end
