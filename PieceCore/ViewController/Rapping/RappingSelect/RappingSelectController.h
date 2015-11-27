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
@property (nonatomic) NSDictionary *params;
@property (nonatomic) UIViewController *parnentVc;
-(void)presentViewWithOrderId:(NSDictionary *)params parnentVc:(UIViewController *)parnentVc;
@end
