//
//  ProfileViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import "ProfileSexTableViewCell.h"
#import "ProfileNameTableViewCell.h"
#import "ProfileBirthdayTableViewCell.h"
#import "ProfileAnniversaryTableViewCell.h"
#import "ProfileAdressTableViewCell.h"
#import "ProfileSendBtnTableViewCell.h"
#import "DatePickerViewController.h"
#import "MonthAndDatePickerViewController.h"
#import "UcIndexpathData.h"
#import "ProfileRecipient.h"
#import "ItemListViewController.h"
#import "LinepayRecipient.h"
#import "linepay_ViewController.h"
#import "LinePayData.h"

@interface ProfileViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate,UITextViewDelegate,ProfileSendBtnDelegate>
@property (nonatomic) NSMutableArray *cellList;
@property (nonatomic) bool isDispDatePicker;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, retain) DatePickerViewController *datePickerViewController;
@property (nonatomic, retain) MonthAndDatePickerViewController *monthDateViewController;
@property (nonatomic) NSMutableArray *tvList ;
@property (nonatomic) NSMutableArray *tfList ;
@property (nonatomic) NSMutableArray *datePickerList;
@property (nonatomic) NSMutableArray *monthDayPickerList;
@property (nonatomic) NSMutableArray *ucIndexpathList;
@property (nonatomic) ProfileRecipient *profileRecipient;
@property (nonatomic, strong) LinepayRecipient *linerecipient;

@property (strong, nonatomic) UITextField *activeTf;
@property (strong, nonatomic) UITextView *activeTv;

@end
