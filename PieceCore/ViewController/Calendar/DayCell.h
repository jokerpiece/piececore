//
//  DayCell.h
//
//  pieceSample
//
//  Created by ハマモト  on 2016/09/29.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *eventLbl;
@property (nonatomic) NSString *yyyyMMdd;

@end
