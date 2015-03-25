//
//  RoundView.m
//  piece
//
//  Created by ハマモト  on 2014/09/19.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "RoundView.h"

@implementation RoundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0].CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 15;
    }
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder {
    self = [super initWithCoder:aDecoder];
	
    if (self) {
        self.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0].CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 15;
        
    }
	
    return self;
}
@end
