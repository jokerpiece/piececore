//
//  RappingQuizeFinishViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/17.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingQuizeFinishViewController.h"

@interface RappingQuizeFinishViewController ()

@end

@implementation RappingQuizeFinishViewController

-(void)viewDidLoadLogic{
    self.oneLbl.text = [self.pinCd substringWithRange:NSMakeRange(0, 1)];
    self.twoLbl.text = [self.pinCd substringWithRange:NSMakeRange(1, 1)];
    self.treeLbl.text = [self.pinCd substringWithRange:NSMakeRange(2, 1)];
    self.forLbl.text = [self.pinCd substringWithRange:NSMakeRange(3, 1)];
}

- (IBAction)closeAction:(id)sender {
    [[UIApplication sharedApplication].delegate.window.rootViewController
     dismissViewControllerAnimated:YES completion:nil];
}
@end
