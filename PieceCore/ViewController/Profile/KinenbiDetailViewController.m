//
//  KinenbiDetailViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/14.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "KinenbiDetailViewController.h"
#import "CoreDelegate.h"

@interface KinenbiDetailViewController ()

@end

@implementation KinenbiDetailViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"KinenbiDetailViewController" owner:self options:nil];
}
- (void)viewDidLoadLogic {
    self.kinenbiMonthDayTf.delegate = self;
    self.kinenbiNameTf.delegate = self;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.kinenbiMonthDayTf) {
        self.datePickerViewController = [[MonthAndDatePickerViewController alloc] initWithNibName:@"MonthAndDatePickerViewController" bundle:nil];
        
        self.datePickerViewController.delegate = self;
        self.datePickerViewController.strDate = textField.text;
        self.isDispDatePicker = YES;
        
        
        [self showModal:self.datePickerViewController.view];
        
        return NO;
    }
//    if (textField == self.kinenbiSyuruiTf) {
//        self.singlePickerViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"idSinglePicker"];
//        self.singlePickerViewController.delegate = self;
//        NSMutableArray *selectList = [NSMutableArray array];
//        [selectList addObject:@"結婚記念日"];
//        [selectList addObject:@"恋人の誕生日"];
//        [selectList addObject:@"母の誕生日"];
//        [selectList addObject:@"父の誕生日"];
//        self.singlePickerViewController.dataList = selectList;
//        self.isDispDatePicker = YES;
//        self.singlePickerViewController.selectData = self.kinenbiSyuruiTf.text;
//        
//        [self showModal:self.singlePickerViewController.view];
//        
//        return NO;
//    }
    return YES;
}

#pragma mark - カスタム日付ピッカー
- (void) showModal:(UIView *) modalView
{
    UIWindow *mainWindow = (((CoreDelegate *) [UIApplication sharedApplication].delegate).window);
    CGPoint middleCenter = modalView.center;
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width * 0.5f, offSize.height * 1.5f);
    modalView.center = offScreenCenter;
    
    [mainWindow addSubview:modalView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    modalView.center = middleCenter;
    [UIView commitAnimations];
}

#pragma mark - カスタム日付ピッカー
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


#pragma mark - カスタム日付ピッカー
- (void) hideModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIView *modalView = (__bridge_transfer UIView *)context;
    [modalView removeFromSuperview];
}

#pragma mark - カスタム日付ピッカー
- (void)didCommitButtonClicked:(KinenbiDetailViewController *)controller selectDate:(NSString *)selectDate{
    [self hideModal:controller.view];
    //controller.delegate = nil;
    [self setDateField :selectDate];
}
#pragma mark - カスタム日付ピッカー
- (void)didCancelButtonClicked:(KinenbiDetailViewController *)controller{
    [self hideModal:controller.view];
    //controller.delegate = nil;
    
}

//オーバーライド
-(void)setDateField:(NSString *)selectDate{
    self.kinenbiMonthDayTf.text = selectDate;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)saveAction:(id)sender {
}
@end
