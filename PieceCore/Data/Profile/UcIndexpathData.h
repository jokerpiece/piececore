//
//  InfputFieldData.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UcIndexpathData : NSObject
@property (nonatomic) NSObject *uc;
@property (nonatomic) NSIndexPath *indexPath;
- (id)initWithUiControll:(NSObject *)uc indexPath:(NSIndexPath *)indexPath;
@end
