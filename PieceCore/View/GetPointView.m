//
//  GetPointView.m
//  piece
//
//  Created by ハマモト  on 2014/10/10.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "GetPointView.h"

@implementation GetPointView

- (id)initWithFrame:(CGRect)frame point:(NSString *)point
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = self.frame.size.width / 2.0;
        self.clipsToBounds = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        UILabel *title_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0,60,300,80)];
        title_lbl.numberOfLines = 0;
        title_lbl.text = @"ポイントをゲット！";
        title_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:28];
        title_lbl.textColor = [UIColor whiteColor];
        title_lbl.textAlignment = NSTextAlignmentCenter;
        
        UILabel *point_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0,140,300,80)];
        point_lbl.numberOfLines = 0;
        point_lbl.text = point;
        point_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:80];
        point_lbl.textColor = [UIColor whiteColor];
        point_lbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title_lbl];
        [self addSubview:point_lbl];
    }
    return self;
}


@end
