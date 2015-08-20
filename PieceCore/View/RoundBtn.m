//
//  RoundBtn.m
//  piece
//
//  Created by ハマモト  on 2014/09/26.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "RoundBtn.h"

@implementation RoundBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder {
    self = [super initWithCoder:aDecoder];
	
    if (self) {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        //        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 15;
        
    }
	
    return self;
}
@end
