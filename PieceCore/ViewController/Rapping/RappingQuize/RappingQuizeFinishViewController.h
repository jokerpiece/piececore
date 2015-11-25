//
//  RappingQuizeFinishViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/17.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"

@interface RappingQuizeFinishViewController : BaseViewController

@property (nonatomic) NSString *pinCd;
@property (weak, nonatomic) IBOutlet UILabel *oneLbl;
@property (weak, nonatomic) IBOutlet UILabel *twoLbl;
@property (weak, nonatomic) IBOutlet UILabel *treeLbl;
@property (weak, nonatomic) IBOutlet UILabel *forLbl;
- (IBAction)closeAction:(id)sender;
@end
