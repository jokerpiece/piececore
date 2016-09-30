//
//  CalendarViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2016/09/29.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CalendarViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UICollectionView *colectionView;
@property (nonatomic) NSString *yyyy;
@property (nonatomic) NSString *mm;
@property (nonatomic) NSString *dd;
@property (nonatomic) int selectedCell;
@property (nonatomic) BaseRecipient *selfRecipient;
@property (nonatomic) NSMutableArray *eventList;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLbl;
- (IBAction)onReserv:(id)sender;

@end
