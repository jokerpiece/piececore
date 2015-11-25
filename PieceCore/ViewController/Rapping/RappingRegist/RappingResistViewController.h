//
//  RappingResistViewController.h
//  pieceSample
//
//  Created by shinden nobuyuki on 2015/11/18.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import "CoreDelegate.h"

@interface RappingResistViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *questionTxt;
@property (weak, nonatomic) IBOutlet UITextField *firstAnswerTxt;
@property (weak, nonatomic) IBOutlet UITextField *secondAnswerTxt;
@property (weak, nonatomic) IBOutlet UITextField *thirdAnswerTxt;
@property (weak, nonatomic) IBOutlet UITextField *forthAnswerTxt;
@property (weak, nonatomic) IBOutlet UIButton *firstAnswerBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondAnswerBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdAnswerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forthAnswerBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;

@property (strong,nonatomic) NSString *orderId;

@end
