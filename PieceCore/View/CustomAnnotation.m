//
//  CustomAnnotation.m
//  piece
//
//  Created by ハマモト  on 2014/10/07.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CustomAnnotation.h"

@interface CustomAnnotation ()
@property CLLocationCoordinate2D coordinate;
@end

@implementation CustomAnnotation
- (id) initWithCoordinate:(CLLocationCoordinate2D)c {
    self.coordinate = c;
    return self;
}
@end
