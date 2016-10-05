//
//  VReserveViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2016/09/29.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "VReserveViewController.h"

@interface VReserveViewController ()

@end

@implementation VReserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"予約";
    self.bikoTv.delegate = self;
    self.bikoTv.layer.borderWidth = 1;
    self.bikoTv.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.bikoTv.layer.cornerRadius = 8;
    // [「改行（Return）」キーの設定]
    self.bikoTv.returnKeyType = UIReturnKeyDone;
    self.nameTf.delegate = self;
    self.NumberTf.delegate = self;
    self.timeTf.delegate = self;
    self.telTf.delegate = self;
    self.bikoTv.delegate =self;
    self.dateLbl.text = [NSString stringWithFormat:@"%@年%@月%@日",self.yyyy,self.mm,self.dd];
    
    // DatePickerの設定
    UIDatePicker* datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeTime];
    datePicker.maximumDate=[NSDate date];
    
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    self.timeTf.inputView = datePicker;
    
    // DoneボタンとそのViewの作成
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle  = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    
    
    // 完了ボタンとSpacerの配置
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完了" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerDoneClicked:)];
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:spacer, spacer1, doneButton, nil]];
    
    // Viewの配置
    self.timeTf.inputAccessoryView = keyboardDoneButtonView;

    // Do any additional setup after loading the view from its nib.
}

#pragma mark DatePickerの編集が完了したら結果をTextFieldに表示
-(void)updateTextField:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    //日付・時刻のフォーマットを指定
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"HH:mm";
    self.timeTf.text = [df stringFromDate:picker.date];
}

#pragma mark datepickerの完了ボタンが押された場合
-(void)pickerDoneClicked:(id)sender {
    [self closeKeyboard];
}

-(void)closeKeyboard{
    [self.view endEditing:YES];
}

- (IBAction)onSend:(id)sender {
    self.isResponse = NO;
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.nameTf.text forKey:@"user_name"];
    [param setValue:self.NumberTf.text forKey:@"people"];
    [param setValue:[NSString stringWithFormat:@"%@-%@-%@",self.yyyy,self.mm,self.dd] forKey:@"reserve_date"];
    [param setValue:self.timeTf.text forKey:@"reserve_time"];
    [param setValue:self.telTf.text forKey:@"phone"];
    [param setValue:self.mailTf.text forKey:@"mail_address"];
    [param setValue:self.bikoTv.text forKey:@"remark"];
    
    [conecter sendActionSendId:SendIdPostCalendarReserve param:param];
    
    
    /*
     app_id = アプリID
     app_key = アプリキー
     user_name =予約名
     people=予約人数
     reserve_date=日付 'yyyy-mm-dd'
     reserve_time=時間 'HH:mm'
     phone=電話番号
     mail_address=メールアドレス
     remark=備考
     */
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    // YES if the old text should be replaced by the new text;
    // NO if the replacement operation should be aborted. (Apple's Reference より)
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [[BaseRecipient alloc]init];
}
-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    
    //    if ([sendId isEqualToString:SendIdGetCalendarEventList]) {
    
    self.recipient = recipient;
    [self showAlert:@"予約完了" message:@"予約を受け付けました。"];
    //  }
}
@end
