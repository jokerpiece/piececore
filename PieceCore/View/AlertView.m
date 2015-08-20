//
//  AlertView.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/13.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "AlertView.h"

@interface AlertView ()
@property (nonatomic) UIViewController *vc;
@end
@implementation AlertView
- (id) initWithView:(UIViewController *)vc {
    if (self = [super init]) {
        self.vc = vc;
    }
    return self;
}

-(void)showAlertWithTitle:(NSString*)title
                  message:(NSString *) message
             btnTitleList:(NSArray*)btnTitleList
            alertResponse:(AlertResponse)response{
    //iOS8以上
    if([UIAlertController class]) {
        UIAlertController* ac = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        int count = 0;
        for (NSString *title in btnTitleList) {
            [ac addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                response(count);
            }]];
            
            count ++;
        }
        [self.vc presentViewController:ac animated:YES completion:nil];
    } else {
        
    }
}
@end
