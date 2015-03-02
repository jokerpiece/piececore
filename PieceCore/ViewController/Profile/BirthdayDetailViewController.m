//
//  BirthdayDetailViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/15.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BirthdayDetailViewController.h"

@interface BirthdayDetailViewController ()

@end

@implementation BirthdayDetailViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"BirthdayDetailViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic {
    self.barthdayTf.delegate = self;
    self.barthdaySyuruiTf.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.barthdayTf) {
        self.datePickerViewController = [[DatePickerViewController alloc] initWithNibName:@"DatePickerViewController" bundle:nil];
        self.datePickerViewController.delegate = self;
        self.datePickerViewController.strDate = self.barthdayTf.text;
        self.isDispDatePicker = YES;
        
        
        [self showModal:self.datePickerViewController.view];
        
        return NO;

    }
    if (textField == self.barthdaySyuruiTf) {
        self.singlePickerViewController = [[SinglePickerViewController alloc] initWithNibName:@"SinglePickerViewController" bundle:nil];
        self.singlePickerViewController.delegate = self;
        NSMutableArray *selectList = [NSMutableArray array];
        [selectList addObject:@"自分"];
        [selectList addObject:@"父"];
        [selectList addObject:@"母"];
        [selectList addObject:@"旦那"];
        [selectList addObject:@"妻"];
        [selectList addObject:@"子供"];
        [selectList addObject:@"恋人"];
        [selectList addObject:@"友達"];
        self.singlePickerViewController.dataList = selectList;
        self.isDispDatePicker = YES;
        self.singlePickerViewController.selectData = self.barthdaySyuruiTf.text;
            
        [self showModal:self.singlePickerViewController.view];
            
        return NO;
    }
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
- (void)didCommitButtonClicked:(DatePickerViewController *)controller selectDate:(NSString *)selectDate{
    [self hideModal:controller.view];
    //controller.delegate = nil;
    [self setDateField :selectDate];
}
#pragma mark - カスタム日付ピッカー
- (void)didCancelButtonClicked:(DatePickerViewController *)controller{
    [self hideModal:controller.view];
    //controller.delegate = nil;
    
}

//オーバーライド
-(void)setDateField:(NSString *)selectDate{
    self.barthdayTf.text = selectDate;
}

- (void)didCommitButtonClickedSinglePicker:(SinglePickerViewController *)controller select:(NSString *)select{
    [self hideModal:controller.view];
    //controller.delegate = nil;
    self.barthdaySyuruiTf.text = select;
}
- (void)didCancelButtonClickedSinglePicker:(SinglePickerViewController *)controller{
    [self hideModal:controller.view];
    //controller.delegate = nil;
    
}

- (IBAction)saveAction:(id)sender {
    KinenbiData *kinenbi = [[KinenbiData alloc]init];
    kinenbi.modelId = (int)self.dataList.count + 1;
    kinenbi.name = [NSString stringWithFormat:@"%@の誕生日",self.barthdaySyuruiTf.text];
    kinenbi.date = self.barthdayTf.text;
    [self.dataList addObject:kinenbi];
}
@end
