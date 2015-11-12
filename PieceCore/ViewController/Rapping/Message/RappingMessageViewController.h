//
//  RappingMessageViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"

@interface RappingMessageViewController : BaseViewController
@property (nonatomic) NSString *message;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
- (IBAction)closeAction:(id)sender;
@end
