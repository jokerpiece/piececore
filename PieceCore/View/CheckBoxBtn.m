//
//  CheckBoxBtn.m
//  pieceSample
//
//  Created by ハマモト  on 2016/01/18.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "CheckBoxBtn.h"

@implementation CheckBoxBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)onChecked{
    if (self.isChecked) {
        self.isChecked = NO;
        [self setImage:[UIImage imageNamed:@"check_on.png"] forState:UIControlStateNormal];
    } else {
        self.isChecked = YES;
        [self setImage:[UIImage imageNamed:@"check_off.png"] forState:UIControlStateNormal];
    }
}
@end
