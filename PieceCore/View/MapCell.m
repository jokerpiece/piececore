//
//  MapCell.m
//  piece
//
//  Created by ハマモト  on 2014/10/07.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "MapCell.h"

@implementation MapCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
