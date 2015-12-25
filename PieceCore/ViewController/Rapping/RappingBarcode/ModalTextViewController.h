//
//  ModalTextViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/12/25.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"

@interface ModalTextViewController : BaseViewController
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (nonatomic) NSString *text;

@end
