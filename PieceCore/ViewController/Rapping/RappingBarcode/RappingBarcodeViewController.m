//
//  RappingBarcodeViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingBarcodeViewController.h"
#import "RappingSelectViewController.h"

@interface RappingBarcodeViewController ()

@end

@implementation RappingBarcodeViewController

-(void)searchItem:(NSString *)detectionString{
    NSURL *url = [NSURL URLWithString:detectionString];
    
    if ([[url host]isEqualToString:UrlSchemeHostRapping]) {
        //ラッピング用バーコードから起動
        NSDictionary *params = [Common dictionaryFromQueryString:[url query]];
        RappingSelectViewController *vc = [[RappingSelectViewController alloc]initWithNibName:@"RappingSelectViewController" bundle:nil
                                           ];
        vc.order_id = params[@"order_id"];
        [self presentViewController:vc animated:NO completion:nil];
        
    }
}
@end
