//
//  RappingBarcodeViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingBarcodeViewController.h"
#import "RappingSelectController.h"
#import "ModalWebViewViewController.h"
#import "ModalTextViewController.h"

@interface RappingBarcodeViewController ()
@property (nonatomic) RappingSelectController *rappingSelectController;
@end

@implementation RappingBarcodeViewController

-(void)searchItem:(NSString *)detectionString{
    NSURL *url = [NSURL URLWithString:detectionString];
    
    if ([[url host]isEqualToString:UrlSchemeHostRapping]) {
        //ラッピング用バーコードから起動
        NSDictionary *params = [Common dictionaryFromQueryString:[url query]];
        
        self.rappingSelectController = [RappingSelectController alloc];
        [self.rappingSelectController presentViewWithOrderId:params parnentVc:self];
    } else {
        DLog(@"%@",[url host]);
        if ([[url scheme] isEqualToString:@"http"] ||
            [[url scheme] isEqualToString:@"https"]) {
            ModalWebViewViewController *modalVc = [[ModalWebViewViewController alloc]initWithNibName:@"ModalWebViewViewController" bundle:nil url:url.absoluteString];
            [self presentViewController:modalVc animated:YES completion:nil];
        } else {
            ModalTextViewController *modalVc = [[ModalTextViewController alloc]initWithNibName:@"ModalTextViewController" bundle:nil];
            modalVc.text = detectionString;
            [self presentViewController:modalVc animated:YES completion:nil];
        }
    }
}
@end
