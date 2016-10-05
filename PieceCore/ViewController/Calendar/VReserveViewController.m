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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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