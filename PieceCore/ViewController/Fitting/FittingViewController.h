//
//  FittingViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BaseViewController.h"
#import "FittingConnector.h"
#import "ItemViewController.h"

@interface FittingViewController : BaseViewController
@property (nonatomic,strong) NSString *question_id;
@property (nonatomic,strong) NSString *answer_num;
@property (strong, nonatomic) FittingConnector *data;
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (weak, nonatomic) IBOutlet UIButton *awnser1Btn;
@property (weak, nonatomic) IBOutlet UIButton *awnser2Btn;
@property (weak, nonatomic) IBOutlet UIView *questionVew;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
- (IBAction)awnser1Action:(id)sender;
- (IBAction)awnser2Action:(id)sender;
@end
