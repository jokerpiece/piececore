//
//  RappingQuizeViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/16.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"

@interface RappingQuizeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *questionNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic) NSString *orderId;
@property (nonatomic) NSString *questionId;
- (IBAction)nextAction:(id)sender;
@end
