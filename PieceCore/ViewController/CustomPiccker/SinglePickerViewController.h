//
//  SinglePickerViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/15.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePickerViewController : UIViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) NSString *selectData;
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic,weak) id delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;
@end

@protocol SinglePickerViewControllerDelegate
- (void)didCommitButtonClickedSinglePicker:(SinglePickerViewController *)controller select:(NSString *)select;
- (void)didCancelButtonClickedSinglePicker:(SinglePickerViewController *)controller;
@end