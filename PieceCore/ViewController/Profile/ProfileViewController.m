//
//  ProfileViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileViewController.h"
#import "CoreDelegate.h"

@interface ProfileViewController ()
@property (nonatomic) NSIndexPath *selectIndexPath;
@end

@implementation ProfileViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"ProfileViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic{
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].profileTitle;
    }
    for (UITableViewCell *cell in self.cellList) {
        if ([cell isKindOfClass:[ProfileNameTableViewCell class]]) {
            UINib *nib = [UINib nibWithNibName:@"ProfileNameTableViewCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@"NameCell"];
        } else if ([cell isKindOfClass:[ProfileSexTableViewCell class]]){
            UINib *nib = [UINib nibWithNibName:@"ProfileSexTableViewCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@"SexCell"];
        } else if ([cell isKindOfClass:[ProfileBirthdayTableViewCell class]]){
            UINib *nib = [UINib nibWithNibName:@"ProfileBirthdayTableViewCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@"BirthdayCell"];
        } else if ([cell isKindOfClass:[ProfileAnniversaryTableViewCell class]]){
            UINib *nib = [UINib nibWithNibName:@"ProfileAnniversaryTableViewCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@"AnniversaryCell"];
        } else if ([cell isKindOfClass:[ProfileAdressTableViewCell class]]){
            UINib *nib = [UINib nibWithNibName:@"ProfileAdressTableViewCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@"AdressCell"];
        } else if ([cell isKindOfClass:[ProfileSendBtnTableViewCell class]]){
            UINib *nib = [UINib nibWithNibName:@"ProfileSendBtnTableViewCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:@"SendBtnCell"];
        }
    }
    self.table.allowsSelection = NO;
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.delegate = self;
    self.table.dataSource = self;
    self.datePickerList = [NSMutableArray array];
    self.monthDayPickerList = [NSMutableArray array];
    self.tvList = [NSMutableArray array];
    self.ucIndexpathList = [NSMutableArray array];
    [self setKeybordNC];
    [self syncAction];
}
- (void)dealloc
{
    [self releaseKeybordNC];
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [param setValue:@"sample" forKey:@"user_id"];
    [param setValue:@"sample" forKey:@"password"];
    [conecter sendActionSendId:SendIdGetProfile param:param];
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [ProfileRecipient alloc];
}

-(void)setDataWithRecipient:(ProfileRecipient *)recipient sendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdGetProfile]) {
        self.profileRecipient = recipient;
        [self.table reloadData];
    } else if ([sendId isEqualToString:SendIdSendProfile]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:@"プロフィール情報を更新しました。"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
}

-(void)setKeybordNC{
    NSNotificationCenter *nc;
    nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keybaordWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)releaseKeybordNC{
    NSNotificationCenter *nc;
    nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSIndexPath *indexPath;
    for (UcIndexpathData *ucData in self.ucIndexpathList) {
        if (self.activeTf == ucData.uc || self.activeTv == ucData.uc) {
            indexPath = ucData.indexPath;
        }
    }
    DLog(@"indexpath:%ld",(long)indexPath.row);
    NSDictionary *userInfo;
    userInfo = [notification userInfo];
 
    CGRect keyboardFrame;
    keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardTop = self.viewSize.height - (keyboardFrame.size.height + 55.f );   // 55.f:予測変換領域の高さ

    UITableViewCell *cell;
    cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row
                                                                    inSection:indexPath.section]];
    CGRect cellFrame;
    cellFrame = cell.frame;
    
    CGPoint offset = CGPointZero;
    offset =  self.table.contentOffset;
    
    CGRect cellRectOrigin = CGRectZero;
    cellRectOrigin.origin.x = cellFrame.origin.x - offset.x;
    cellRectOrigin.origin.y = cellFrame.origin.y - offset.y;
    
    CGFloat cellBottom = cellRectOrigin.origin.y + cellFrame.size.height + 30.f;   // 30.f:マージン
    
    if (cellBottom < keyboardTop) {
        return;
    }

    UIEdgeInsets insets;
    insets = UIEdgeInsetsMake(0.0f, 0.0f, keyboardTop, 0.0f);
    
    NSTimeInterval duration;
    UIViewAnimationCurve animationCurve;
    void (^animations)(void);
    duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    animations = ^(void) {
        self.table.contentInset = insets;
        self.table.scrollIndicatorInsets = insets;
    };
    [UIView animateWithDuration:duration delay:0.0 options:(animationCurve << 16) animations:animations completion:nil];
    
    CGRect rect = cell.frame;
    if (self.activeTv == nil) {
        rect.origin.y = cellFrame.origin.y - 300.f;
    } else {
        rect.origin.y = cellFrame.origin.y + 20.0f;
    }
    
    DLog(@"rectY %f",rect.origin.y);
    [self.table scrollRectToVisible:rect animated:YES];
}

- (void)keybaordWillHide:(NSNotification*)notification
{
    NSDictionary *userInfo;
    userInfo = [notification userInfo];
    
    NSTimeInterval duration;
    UIViewAnimationCurve animationCurve;
    void (^animations)(void);
    duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    animations = ^(void) {
        // insets を 0 にする
        self.table.contentInset = UIEdgeInsetsZero;
        self.table.scrollIndicatorInsets = UIEdgeInsetsZero;
    };
    [UIView animateWithDuration:duration delay:0.0 options:(animationCurve << 16) animations:animations completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"";
    UITableViewCell *tmpCell = [self.cellList objectAtIndex:indexPath.row];
    if ([tmpCell isKindOfClass:[ProfileNameTableViewCell class]]) {
        CellIdentifier = @"NameCell";
    } else if ([tmpCell isKindOfClass:[ProfileSexTableViewCell class]]){
        CellIdentifier = @"SexCell";
    } else if ([tmpCell isKindOfClass:[ProfileBirthdayTableViewCell class]]){
        CellIdentifier = @"BirthdayCell";
    } else if ([tmpCell isKindOfClass:[ProfileAnniversaryTableViewCell class]]){
        CellIdentifier = @"AnniversaryCell";
    } else if ([tmpCell isKindOfClass:[ProfileAdressTableViewCell class]]){
        CellIdentifier = @"AdressCell";
    } else if ([tmpCell isKindOfClass:[ProfileSendBtnTableViewCell class]]){
        CellIdentifier = @"SendBtnCell";
    }
    BaseInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //[cell setInputList];
    [cell setDataWithProfileRecipient:self.profileRecipient];
    for (UITextField *tf in cell.tfList) {
        tf.delegate = self;
        [self.ucIndexpathList addObject:[[UcIndexpathData alloc]initWithUiControll:tf indexPath:indexPath]];
    }
    for (UITextView *tv in cell.tvList) {
        tv.delegate = self;
        [self setToolbarInTextView:tv];
        [self.tvList addObject:tv];
        [self drowFrameBorder:tv];
        [self.ucIndexpathList addObject:[[UcIndexpathData alloc]initWithUiControll:tv indexPath:indexPath]];
    }
    for (UITextField *tf in cell.datePickerList) {
        tf.delegate = self;
        [self.datePickerList addObject:tf];
    }
    for (UITextField *tf in cell.monthDayPickerList) {
        tf.delegate = self;
        [self.monthDayPickerList addObject:tf];
    }
    
    if ([cell isKindOfClass:[ProfileSendBtnTableViewCell class]]) {
        ProfileSendBtnTableViewCell *sendCell = (ProfileSendBtnTableViewCell*)cell;
        sendCell.delegate = self;
    }
       
    return (UITableViewCell *)cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tmpCell = [self.cellList objectAtIndex:indexPath.row];
    if ([tmpCell isKindOfClass:[ProfileNameTableViewCell class]]) {
        return 120.0f;
    } else if ([tmpCell isKindOfClass:[ProfileSexTableViewCell class]]){
        return 100.0f;
    } else if ([tmpCell isKindOfClass:[ProfileBirthdayTableViewCell class]]){
        return 110.0f;
    } else if ([tmpCell isKindOfClass:[ProfileAnniversaryTableViewCell class]]){
        return 179.0f;
    } else if ([tmpCell isKindOfClass:[ProfileAdressTableViewCell class]]){
        return 240.0f;
    } else if ([tmpCell isKindOfClass:[ProfileSendBtnTableViewCell class]]){
        return 100.0f;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexPath = indexPath;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.activeTf = textField;
    self.activeTv = nil;
    for (UITextField *tf in self.datePickerList) {
        if (textField == tf) {
            self.datePickerViewController = [[DatePickerViewController alloc] initWithNibName:@"DatePickerViewController" bundle:nil];
            self.datePickerViewController.delegate = self;
            self.datePickerViewController.datePicker.datePickerMode = UIDatePickerModeDate;
            self.isDispDatePicker = YES;
            [self showModal:self.datePickerViewController.view];
                
            return NO;
                
        }
    }
    for (UITextField *tf in self.monthDayPickerList) {
        if (textField == tf) {
            self.monthDateViewController = [[MonthAndDatePickerViewController alloc] initWithNibName:@"MonthAndDatePickerViewController" bundle:nil];
            self.monthDateViewController.delegate = self;
            self.isDispDatePicker = YES;
            
            
            [self showModal:self.monthDateViewController.view];
            
            return NO;
            
        }
    }
    
    return YES;
}

- (BOOL) textViewShouldBeginEditing: (UITextView*) textView
{
    self.activeTv = textView;
    self.activeTf = nil;
    return YES;
}

-(void)drowFrameBorder:(UITextView *)tv{
    tv.layer.borderWidth = 1.0f;
    tv.layer.cornerRadius = 5.0f;
    tv.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void) showModal:(UIView *) modalView
{
    UIWindow *mainWindow = (((CoreDelegate *) [UIApplication sharedApplication].delegate).window);
    
    CGPoint offScreenCenter = CGPointMake(self.viewSize.width * 0.5f, self.viewSize.height * 1.5f);
    modalView.center = offScreenCenter;
    modalView.frame = CGRectMake(0, 0, self.viewSize.width, self.viewSize.height);
    [mainWindow addSubview:modalView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    modalView.center = CGPointMake(self.viewSize.width * 0.5f, self.viewSize.height * 0.5f);
    [UIView commitAnimations];
}

- (void) hideModal:(UIView*) modalView
{
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width * 0.5f, offSize.height * 1.5f);
    [UIView beginAnimations:nil context:(__bridge_retained void *)(modalView)];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideModalEnded:finished:context:)];
    modalView.center = offScreenCenter;
    [UIView commitAnimations];
}


- (void) hideModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIView *modalView = (__bridge_transfer UIView *)context;
    [modalView removeFromSuperview];
}

- (void)didCommitButtonClicked:(DatePickerViewController *)controller selectDate:(NSString *)selectDate{
    [self hideModal:controller.view];
    self.activeTf.text = selectDate;
    
}
- (void)didCancelButtonClicked:(DatePickerViewController *)controller{
    [self hideModal:controller.view];
    //controller.delegate = nil;
    
}

-(void)setToolbarInTextView:(UITextView *)tv{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    [toolBar sizeToFit];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *_commitBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeKeyboard:)];
    NSArray *toolBarItems = [NSArray arrayWithObjects:spacer, _commitBtn, nil];
    [toolBar setItems:toolBarItems animated:YES];
    tv.inputAccessoryView = toolBar;
}

-(void)closeKeyboard:(id)sender{
    for (UITextView *tv in self.tvList) {
        [tv resignFirstResponder];
    }
    
}

- (void)didProfileSendButton{
    NSLog(@"%@",self.profileRecipient.sei);
    for (BaseInputCell *cell in self.cellList) {
        [cell saveDataWithProfileRecipient:self.profileRecipient];
    }
    
    self.isResponse = NO;
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [param setValue:self.profileRecipient.user_id forKey:@"user_id"];
    [param setValue:self.profileRecipient.password forKey:@"password"];
    [param setValue:self.profileRecipient.sei forKey:@"sei"];
    [param setValue:self.profileRecipient.mei forKey:@"mei"];
    [param setValue:self.profileRecipient.berth_day forKey:@"berth_day"];
    [param setValue:self.profileRecipient.post forKey:@"post"];
    [param setValue:self.profileRecipient.address forKey:@"adress"];
    [param setValue:self.profileRecipient.sex forKey:@"sex"];
    [param setValue:self.profileRecipient.tel forKey:@"tel"];
    [param setValue:self.profileRecipient.mail_address forKey:@"mail_address"];
    [param setValue:self.profileRecipient.anniversary_name forKey:@"anniversary_name"];
    [param setValue:self.profileRecipient.anniversary forKey:@"anniversary"];
    [conecter sendActionSendId:SendIdSendProfile param:param];
    NSLog(@"%@",self.profileRecipient.sei);
    
    [self dataSet];
    
    linepay_ViewController *vc = [[linepay_ViewController alloc]init];
    NetworkConecter *conecter_2 = [NetworkConecter alloc];
    conecter_2.delegate = self;
    NSMutableDictionary *param_2 = [NSMutableDictionary dictionary];
    [param_2 setValue:[Common getUuid] forKeyPath:@"uuid"];
    [param_2 setValue:vc.item_name forKeyPath:@"productName"];
    [param_2 setValue:vc.img_url forKeyPath:@"productImageUrl"];
    [param_2 setValue:vc.item_price forKeyPath:@"amount"];
    [param_2 setValue:vc.app_url forKeyPath:@"confirmUrl"];
    [conecter_2 sendActionSendId:SendIdLinePay param:param_2];
    
   // [self checkLineInstall];
    
    NSString *string = vc.string;
    NSURL *url = [NSURL URLWithString:string];
    [[UIApplication sharedApplication] openURL:url];
    

}

-(void)dataSet
{
    NSUserDefaults *profile_data = [NSUserDefaults standardUserDefaults];
    [profile_data setObject:self.profileRecipient.user_id forKey:@"USER_ID"];
    [profile_data setValue:self.profileRecipient.password forKey:@"PASSWORD"];
    [profile_data setValue:self.profileRecipient.sei forKey:@"SEI"];
    [profile_data setValue:self.profileRecipient.mei forKey:@"MEI"];
    [profile_data setValue:self.profileRecipient.berth_day forKey:@"BERTH_DAY"];
    [profile_data setValue:self.profileRecipient.post forKey:@"POST"];
    [profile_data setValue:self.profileRecipient.address forKey:@"ADRESS"];
    [profile_data setValue:self.profileRecipient.sex forKey:@"SEX"];
    [profile_data setValue:self.profileRecipient.tel forKey:@"TEL"];
    [profile_data setValue:self.profileRecipient.mail_address forKey:@"MAIL_ADDRESS"];
    [profile_data setValue:self.profileRecipient.anniversary_name forKey:@"ANNIVERSARY_NAME"];
    [profile_data setValue:self.profileRecipient.anniversary forKey:@"ANNIVERSARY"];
    
    [profile_data setValue:@"Testだよ！" forKey:@"TEST"];
    
    [profile_data synchronize];
    
    NSString *test = [profile_data stringForKey:@"TEST"];
    NSLog(@"%@", test);
    
    [profile_data setValue:@"あいうえお！" forKey:@"TEST"];
    [profile_data synchronize];
    test = [profile_data stringForKey:@"TEST"];
    NSLog(@"%@", test);
    
    [profile_data removeObjectForKey:@"TEST"];
    test = [profile_data stringForKey:@"TEST"];
    NSLog(@"%@", test);

    
//    NSString *sei_str = self.profileRecipient.sei;
//    NSString *get_sei =  [Setdata getsei:sei_str];
//    NSLog(@"%@", get_sei);
//    
//    NSString *mei_str = self.profileRecipient.mei;
//    NSString *get_mei = [Setdata getmei:mei_str];
//    NSLog(@"%@", get_mei);
//    
//    NSString *address_str = self.profileRecipient.address;
//    NSString *get_address = [Setdata getmail:address_str];
//    NSLog(@"%@", get_address);
//    
//    NSString *mail_str = self.profileRecipient.mail_address;
//    NSString *get_mail = [Setdata getmail:mail_str];
//    NSLog(@"%@",get_mail);
    
}

-(void)checkLineInstall{
    NSString *string = self.linerecipient.paymentUrl;
    NSURL *url = [NSURL URLWithString:string];
    [[UIApplication sharedApplication] openURL:url];
    
    BOOL installed = [[UIApplication sharedApplication] canOpenURL:url];
    
    if(installed) {
        [[UIApplication sharedApplication] canOpenURL:url];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                        message:@"iPhone上にLINEがありません。　　　インストールしますか？"
                                                       delegate:self
                                              cancelButtonTitle:@"キャンセル"
                                              otherButtonTitles:@"インストール", nil];
        [alert show];
    }
    

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSString *line_Url = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=443904275&mt=8";
        NSURL *url = [NSURL URLWithString:line_Url];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
