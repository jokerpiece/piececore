//
//  InfputFieldData.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "UcIndexpathData.h"

@implementation UcIndexpathData
- (id)initWithUiControll:(NSObject *)uc indexPath:(NSIndexPath *)indexPath
{
    self = [super init];
    if (self) {
        self.uc = uc;
        self.indexPath = indexPath;
    }
    return self;
}
@end
