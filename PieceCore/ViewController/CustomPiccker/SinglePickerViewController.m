//
//  SinglePickerViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/15.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SinglePickerViewController.h"

@interface SinglePickerViewController ()

@end

@implementation SinglePickerViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"SinglePickerViewController" owner:self options:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    int i = 0;
    int selectrow = 0;
    for (NSString *syurui in self.dataList) {
        if ([self.selectData isEqualToString:syurui]) {
            selectrow = i;
            
        }
        i ++;
    }
    [self.pickerView selectRow:selectrow inComponent:0 animated:NO];
    // Do any additional setup after loading the view.
}

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.delegate didCancelButtonClickedSinglePicker:self];
}


# pragma mark UIPIkerView's Delegate
// 列(component)の数を返す
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 列(component)に対する、行(row)の数を返す
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.dataList count];
    }
    return 0;
}

// 列(component)と行(row)に対応する文字列を返す
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0: //
            return [self.dataList objectAtIndex:row];
    }
    return nil;
}



- (IBAction)cancelAction:(id)sender {
    [self.delegate didCancelButtonClickedSinglePicker:self];
}

- (IBAction)doneAction:(id)sender {
    [self.delegate didCommitButtonClickedSinglePicker:self select:[self.dataList objectAtIndex:[self.pickerView selectedRowInComponent:0]]];
}
@end
