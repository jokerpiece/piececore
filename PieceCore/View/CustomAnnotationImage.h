//
//  CustomAnnotationImage.h
//  pieceSample
//
//  Created by mikata on 2015/11/20.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface CustomAnnotationImage : NSObject <MKAnnotation>
@property (readwrite, nonatomic) CLLocationCoordinate2D coordinate; // required
@property (readwrite, nonatomic, strong) NSString* title; // optional
@property (readwrite, nonatomic, strong) NSString* subtitle; // ditto
@property (readwrite, nonatomic, strong) NSString *imagePath; // for example
@property (readwrite, nonatomic, strong) NSString *shopInfoId; // for example
@end

@implementation CustomAnnotationImage
@synthesize coordinate, title, subtitle, imagePath;
@end
