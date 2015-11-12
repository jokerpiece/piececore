//
//  RappingMessageViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingMessageViewController.h"

@interface RappingMessageViewController ()

@end

@implementation RappingMessageViewController

-(void)viewDidLoadLogic{
    self.messageLbl.text = self.message;
    
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        //        [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
        ;
    }];
}
@end
