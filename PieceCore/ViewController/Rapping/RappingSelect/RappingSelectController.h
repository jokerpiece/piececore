//
//  RappingSelectViewModel.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RappingSelectController : NSObject
@property (nonatomic) NSString *orderId;
@property (nonatomic) UIViewController *parnentVc;
-(void)presentViewWithOrderId:(NSString *)orderId parnentVc:(UIViewController *)parnentVc;
@end
