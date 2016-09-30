//
//  VReserveViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2016/09/29.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VReserveViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic) NSString *yyyy;
@property (nonatomic) NSString *mm;
@property (nonatomic) NSString *dd;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *NumberTf;
@property (weak, nonatomic) IBOutlet UITextField *dateTf;
@property (weak, nonatomic) IBOutlet UITextField *timeTf;
@property (weak, nonatomic) IBOutlet UITextField *telTf;
@property (weak, nonatomic) IBOutlet UITextField *mailTf;
@property (weak, nonatomic) IBOutlet UITextView *bikoTv;
- (IBAction)onSend:(id)sender;
@end
